namespace GxjtBHMS.Models.Encryption
{
    class PlainTextEncryptStrategy : AppEncryptionStrategy
    {
        public override string Encrypt(string plainText)
        {
            return plainText;
        }
    }
}
