namespace GxjtBHMS.Models.Encryption
{
    public class EncryptContext
    {
        readonly AppEncryptionStrategy _strategy;

        public EncryptContext(AppEncryptionStrategy strategy)
        {
            _strategy = strategy;
        }

        public string Encrypt(string plainText)
        {
            return _strategy.Encrypt(plainText);
        }
    }
}
