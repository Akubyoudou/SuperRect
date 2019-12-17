public class SuperRect
{
  public int[] blue;
  public int[] green;
  public int[] red;
  public int[] gray;
  public float sizeX=1;
  public float sizeY=1;
  public int widthnum=0;
  public int heightnum=0;
  public int colornum=0;
  public SuperRect(String binaryfilepath,float z, float w)
  {
    byte[] sbytes = loadBytes(binaryfilepath);
    int[] bytes=new int[sbytes.length];
    for (int i = 0; i < sbytes.length; i++) 
    {
      bytes[i] = sbytes[i] & 0xff;
      //コピペでint型配列化可能
      //print(bytes[i] + ",");
    }
    Init(bytes,z, w);
  }
  public SuperRect(int bytes[],float z, float w)
  {
    Init(bytes,z, w);
  }
  public void Init(int bytes[],float z, float w)
  {
    sizeX=z;
    sizeY=w;
    int _widthnum[]={bytes[18], bytes[19], bytes[20], bytes[21]};
    int _heightnum[]={bytes[22], bytes[23], bytes[24], bytes[25]};
    widthnum=BytesToInt(_widthnum);
    heightnum=BytesToInt(_heightnum);
    int _colornum[]={bytes[28], bytes[29]};
    colornum=BytesToInt(_colornum);

    if (colornum==24) 
    {
      int lim=(bytes.length-54)/3;
      blue=new int[lim];
      //println(blue.length+""+lim+""+widthnum*heightnum);
      red=new int[lim];
      green=new int[lim];
      for (int i=0; i<lim; i++)
      {
        //println("r:"+bytes[54+i*3+2]+" g:"+bytes[54+i*3+1]+" b:"+bytes[54+i*3]);
        blue[i]=bytes[54+i*3];
        green[i]=bytes[54+i*3+1];
        red[i]=bytes[54+i*3+2];
      }
    } else for (int i=0; i<bytes.length-54; i++)
    {
      gray[i]=bytes[54+i];
    }
  }
  public void Show(float posX,float posY)
  {
    int count=0;
    for (int h=0; h<heightnum; h++)for (int w=0; w<widthnum; w++)
    {
      if (colornum==24)
      {
        fill(red[count], green[count], blue[count]);
        Rect(posX,posY,w, h);
      } else
      {
        fill(gray[count]);
        Rect(posX,posY,w, h);
      }
      count++;
    }
  }
  private void Rect(float posX,float posY,int w, int h)
  {
    noStroke();
    rect(posX+w*sizeX/widthnum, posY+sizeY-h*sizeY/heightnum, sizeX/widthnum, -sizeY/heightnum);
  }
}
public int BytesToInt(int _bytes[])
{
  int res=0;
  for (int i=_bytes.length; i!=0; i--)
  {
    res+=_bytes[i-1]*Math.pow(256, i-1);
  }
  return res;
}
