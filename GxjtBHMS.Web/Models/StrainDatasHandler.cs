using Microsoft.AspNet.SignalR;
using System;
using System.Collections.Generic;
using System.Threading;

namespace GxjtBHMS.Web.Models
{
    public class StrainDatasHandler:Hub
    {
        readonly IList<double> _datas = new List<double>();

        public StrainDatasHandler()
        {
            Init();
        }

        public void Init()
        {
            Random rnd = new Random();
            for (int i = 0; i < 5000; i++)
            {
                _datas.Add(Math.Round(100 * rnd.NextDouble(), 2));
            }
            
        }

        public void Bubbling()
        {
            foreach (var item in _datas)
            {
                Thread.Sleep(1000);
                Clients.All.fetch(item);
            }
        }
    }
}