using System;
using System.Collections.Generic;

namespace GxjtBHMS.Models
{
    public abstract class EntityBase<TId> 
    {

        IList<string> _brokenRules = new List<string>();

        bool _idHasBeenSet = false;

        TId _id;

        public EntityBase() { }

        public EntityBase(TId id)
        {
            Id = id;
        }

        public TId Id
        {
            get { return _id; }
            set
            {
                if (_idHasBeenSet)
                {
                    ThrowExceptionIfOverwritingAnId();
                }
                _id = value;
                _idHasBeenSet = true;
            }
        }

        void ThrowExceptionIfOverwritingAnId()
        {
            throw new ApplicationException("Cannot change the id of an entity.");
        }

        public bool IsValid()
        {
            ClearCollectionofBrokenRules();
            CheckForBrokenRules();
            return _brokenRules.Count == 0;
        }

        /// <summary>
        /// 检查是否违反模型业务规则
        /// </summary>
        protected virtual void CheckForBrokenRules() { }

        void ClearCollectionofBrokenRules()
        {
            _brokenRules.Clear();
        }



    }
}
