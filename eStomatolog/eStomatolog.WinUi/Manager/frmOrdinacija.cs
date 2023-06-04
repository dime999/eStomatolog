using eStomatologModel;
using eStomatologModel.Requests;
using Microsoft.VisualBasic.ApplicationServices;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace eStomatolog.WinUi.Manager
{
    public partial class frmOrdinacija : Form
    {
        private Ordinacije _ordinacija { get; set; }
        private Doktor _user { get; set; }
        private APIService _gradService = new APIService("Grad");
        private APIService _ordinacijaService = new APIService("Ordinacija");

        public frmOrdinacija(Ordinacije ordinacija,Doktor user)
        {
            _ordinacija= ordinacija;
            _user= user;
            InitializeComponent();
        }
        private async void frmHairSalon_Load(object sender, EventArgs e)
        {
            await LoadData();
        }

        private async Task LoadData()
        {
            await LoadCities();
            await LoadBasicInfo();
           
        }

       

        private async Task LoadBasicInfo()
        {
            txtIme.Text = _ordinacija.Naziv;
            txtAddress.Text = _ordinacija.Adresa;
            txtTelefon.Text = _ordinacija.Telefon;
           
        }

        private async Task LoadCities()
        {
            var gradovi = await _gradService.Get<List<Grad>>();
            cbGradovi.DataSource = gradovi;
            cbGradovi.DisplayMember = "Naziv";
            cbGradovi.ValueMember = "GradId";

        }

        private async void btnSave_Click(object sender, EventArgs e)
        {
            var grad = cbGradovi.SelectedItem as Grad;
            int gradId = grad.GradId;
            var req = new OrdinacijaUpsertRequest
            {
                Adresa = txtAddress.Text,
                Telefon = txtTelefon.Text,
                Naziv = txtTelefon.Text,
                GradId = gradId

            };
            var Ordinacije = await _ordinacijaService.Put<Ordinacije>(_ordinacija.OrdinacijaId,req);
            MessageBox.Show("Uspješno ste uredili osnovne informacije ordinacije");
        }
  

        private void FormInit(Form form)
        {
            this.Hide();
            form.Closed += (s, args) => this.Show();
            form.ShowDialog();
        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }

        private void btnDoktori_Click(object sender, EventArgs e)
        {
            var forma = new Doktori.frmDoktori(_ordinacija, _user);
            this.Hide();
            forma.Closed += (s, args) => this.Show();
            forma.ShowDialog();
        }

        private void btnServices_Click(object sender, EventArgs e)
        {
            var forma = new Pacijent.frmPacijenti(_ordinacija);
            this.Hide();
            forma.Closed += (s, args) => this.Show();
            forma.ShowDialog();
        }
    }
}
