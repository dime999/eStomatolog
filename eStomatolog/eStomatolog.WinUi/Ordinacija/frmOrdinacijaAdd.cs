using eStomatolog.WinUi.Manager;
using eStomatologModel;
using Microsoft.VisualBasic.ApplicationServices;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace eStomatolog.WinUi.Ordinacija
{
    public partial class frmOrdinacijaAdd : Form
    {

        private Doktor _doktor { get; set; }
        private APIService _ordinacijaService = new APIService("Ordinacija");
        private APIService _korisnik = new APIService("Korisnik");
        public frmOrdinacijaAdd(Doktor doktor)
        {
            _doktor = doktor;
            InitializeComponent();
             
        }

        private void frmOrdinacijaAdd_Load(object sender, EventArgs e)
        {
            LoadData();
        }

        private async Task LoadData()
        {
            UcitajOrdinacije();
        }

        private async Task UcitajOrdinacije()
        {
            var ordinacije = await _ordinacijaService.Get<List<Ordinacije>>();
            cbOrdinacije.DataSource = ordinacije;
            cbOrdinacije.DisplayMember = "Naziv";
            cbOrdinacije.ValueMember = "OrdinacijaId";
        }

     

        private async void btnBack_Click(object sender, EventArgs e)
        {
            var korisnik = await _korisnik.GetById<Korisnik>(_doktor.KorisnikId);

            var forma = new Manager.ManagerHome(korisnik);
            this.Hide();
            forma.Closed += (s, args) => this.Show();
            forma.ShowDialog();
        }
    }
}
