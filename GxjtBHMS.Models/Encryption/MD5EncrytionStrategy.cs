using System.Security.Cryptography;
using System.Text;

namespace GxjtBHMS.Models.Encryption
{
    class MD5EncrytionStrategy : AppEncryptionStrategy
    {
        public override string Encrypt(string plainText)
        {
            MD5 md5Method = new MD5CryptoServiceProvider();
            var data = Encoding.Default.GetBytes(plainText);
            var md5date = md5Method.ComputeHash(Encoding.UTF8.GetBytes(plainText));
            md5Method.Clear();
            var encryptionString = "";
            for (var i = 0; i < md5date.Length; i++)
            {
                encryptionString += md5date[i].ToString("x").PadLeft(2, '0');
            }
            return encryptionString;
        }
    }
}
