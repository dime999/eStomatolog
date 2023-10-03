using System;
using System.Net;
using System.Net.Mail;


namespace MailingService
{
	public class EmailSender : IEmailSender
	{

        private readonly string _outlookMail = Environment.GetEnvironmentVariable("OUTLOOK_MAIL") ?? "estomatolog@outlook.com";
        private readonly string _outlookPass = Environment.GetEnvironmentVariable("OUTLOOK_PASS") ?? "RazvojSoftvera2!";

        

        public EmailSender()
		{
		}

        public Task SendEmailAsync(string email, string subject, string message)
        {
            var client = new SmtpClient("smtp.office365.com", 587)
            {
                EnableSsl = true,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(_outlookMail, _outlookPass)
            };

            return client.SendMailAsync(
                new MailMessage(from: _outlookMail,
                                to: email,
                                subject,
                                message
                                ));

        }
    }
}

