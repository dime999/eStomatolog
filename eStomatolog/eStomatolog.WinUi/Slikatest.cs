using eStomatologModel;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace eStomatolog.WinUi
{
    public partial class Slikatest : Form
    {

        public APIService OrdinacijaService { get; set; } = new APIService("Ordinacija");

        public Slikatest()
        {
            InitializeComponent();
            this.Load += Form1_Load;
        }

        

        private async void Form1_Load(object sender, EventArgs e)
        {
          var ordinacija = await OrdinacijaService.Get<List<Ordinacija>>();
          byte[] imageBytes = null;
           foreach (var i in ordinacija)
            {
                if(i.OrdinacijaId==3)
                {
                   imageBytes = i.Slika;
                }
            }
           
            Image image;
            using (MemoryStream ms = new MemoryStream(imageBytes))
            {
                image = Image.FromStream(ms);
            }

            pictureBox1.Image = image; 
        }
    }
}
