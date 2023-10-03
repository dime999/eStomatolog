using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel
{
    public class ReservationNotifier
    {
        public ReservationNotifier()
        {
        }
        public int Id { get; set; }
        public string  DoktorIme { get; set; }
        public string Email { get; set; }
        public DateTime DatumVrijeme { get; set; }
    }
}
