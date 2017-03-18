namespace GxjtBHMS.Models.Encryption
{
    public abstract class AppEncryptionStrategy
    {
        /// <summary>
        /// 加密
        /// </summary>
        /// <param name="plainText">明文</param>
        /// <returns>密文</returns>
        public abstract string Encrypt(string plainText);
    }
}
