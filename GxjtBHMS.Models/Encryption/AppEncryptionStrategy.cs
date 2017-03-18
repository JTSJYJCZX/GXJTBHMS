namespace GxjtBHMS.Models.Encryption
{
    public abstract class AppEncryptionStrategy
    {
        public abstract string Encrypt(string plainText);
    }
}
