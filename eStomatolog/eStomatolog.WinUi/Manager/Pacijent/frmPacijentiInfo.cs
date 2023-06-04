using eStomatologModel;
using eStomatologModel.Requests;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace eStomatolog.WinUi.Manager.Pacijent
{
    public partial class frmPacijentiInfo : Form
    {
        private eStomatologModel.Pacijent  _pacijent { get; set; }
        private Ordinacije _ordinacija { get; set; }
        public APIService GradService { get; set; } = new APIService("Grad");
        public APIService PacijentService { get; set; } = new APIService("Pacijent");
        public frmPacijentiInfo(eStomatologModel.Pacijent pacijent,Ordinacije ordinacija)
        {
            _ordinacija= ordinacija;
            _pacijent = pacijent;
            InitializeComponent();
        }

        private void frmPacijentiInfo_Load(object sender, EventArgs e)
        {
            LoadData();
           
        }
        private async Task LoadData()
        {
            await LoadGradovi();
            await LoadInfo();
        }

        private async Task LoadInfo()
        {
            txtIme.Text= _pacijent.Ime;
            txtPrezime.Text = _pacijent.Prezime;
            txtTelefon.Text = _pacijent.Telefon;
            
        }
        private async Task LoadGradovi()
        {
            var grad = await GradService.Get<List<Grad>>();
            cblGradovi.DataSource = grad;
            cblGradovi.DisplayMember = "Naziv";
            cblGradovi.ValueMember = "GradId";
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            PacijentUpdateRequest request = new PacijentUpdateRequest()
            {
                Ime = txtIme.Text,
                Prezime = txtPrezime.Text,
                Telefon = txtTelefon.Text,
            };

            var grad = cblGradovi.SelectedItem as Grad;
            int gradId = grad.GradId;
            request.GradId= gradId;
            var pacijent =  PacijentService.Put<PacijentUpdateRequest>(_pacijent.Id, request);

            if (pacijent != null)
            {
                MessageBox.Show("Uspješno ste uredili podatke pacijenta.", "Success");
            }
            else
            {
                MessageBox.Show("Podaci se nisu mogli spremiti.", "Failure");
            }
        }
    }
}
