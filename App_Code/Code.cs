using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

/// <summary>
/// Code 的摘要说明
/// </summary>
public class Code
{
    public Code()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }
    /// <summary>
            /// 加密
            /// </summary>
            /// <param name="str"></param>
            /// <param name="key"></param>
            /// <returns></returns>
    public static string Encode(string str, string key)
    {
        DESCryptoServiceProvider provider = new DESCryptoServiceProvider();
        provider.Key = Encoding.ASCII.GetBytes(key.Substring(0, 8));
        provider.IV = Encoding.ASCII.GetBytes(key.Substring(0, 8));
        byte[] bytes = Encoding.GetEncoding("GB2312").GetBytes(str);
        MemoryStream stream = new MemoryStream();
        CryptoStream stream2 = new CryptoStream(stream, provider.CreateEncryptor(), CryptoStreamMode.Write);
        stream2.Write(bytes, 0, bytes.Length);
        stream2.FlushFinalBlock();
        StringBuilder builder = new StringBuilder();
        foreach (byte num in stream.ToArray())
        {
            builder.AppendFormat("{0:X2}", num);
        }
        stream.Close();
        return builder.ToString();
    }

    /// <summary>
            /// Des 解密 GB2312 
            /// </summary>
            /// <param name="str">Desc string</param>
            /// <param name="key">Key ,必须为8位 </param>
            /// <returns></returns>
    public static string Decode(string str, string key)
    {
        DESCryptoServiceProvider provider = new DESCryptoServiceProvider();
        provider.Key = Encoding.ASCII.GetBytes(key.Substring(0, 8));
        provider.IV = Encoding.ASCII.GetBytes(key.Substring(0, 8));
        byte[] buffer = new byte[str.Length / 2];
        for (int i = 0; i < (str.Length / 2); i++)
        {
            int num2 = Convert.ToInt32(str.Substring(i * 2, 2), 0x10);
            buffer[i] = (byte)num2;
        }
        MemoryStream stream = new MemoryStream();
        CryptoStream stream2 = new CryptoStream(stream, provider.CreateDecryptor(), CryptoStreamMode.Write);
        stream2.Write(buffer, 0, buffer.Length);
        stream2.FlushFinalBlock();
        stream.Close();
        return Encoding.GetEncoding("GB2312").GetString(stream.ToArray());
    }
}