using System;
namespace eStomatologServices.Interfejsi
{
	public interface IMessageProducer
	{
		public void SendingMessage(string message);
		public void SendingObject<T>(T obj);

    }
}

