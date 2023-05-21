using eStomatologModel;
using eStomatologModel.SearchObjects;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Xml.Linq;

namespace eStomatolog.WinUi
{
    public partial class frmKorisnici : Form
    {

        public APIService KorisinciService { get; set; } = new APIService("Korisnik");
        public frmKorisnici()
        {
            InitializeComponent();
            dgvKorisnici.AutoGenerateColumns = true;
        }

        private async void btnPrikazi_Click(object sender, EventArgs e)
        {
            var searchObject = new KorisnikSearchObject();
            searchObject.KorisnickoIme = txtKorisnickoIme.Text;
            searchObject.NameFTS = txtIme.Text;
            searchObject.IncludeRoles = true;

            var list = await KorisinciService.Get<List<Korisnik>>(searchObject);

            dgvKorisnici.DataSource = list;
        }
    }
}
