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
        private Doktor _doktor { get; set; }
        public APIService GradService { get; set; } = new APIService("Grad");
        public APIService PacijentService { get; set; } = new APIService("Pacijent");
        public APIService DijagnozaService { get; set; } = new APIService("Dijagnoza");
        public APIService DijagnozaPacijentService { get; set; } = new APIService("GetByPacijent");
        public frmPacijentiInfo(eStomatologModel.Pacijent pacijent,Ordinacije ordinacija,Doktor doktor)
        {
            _ordinacija= ordinacija;
            _pacijent = pacijent;
            _doktor = doktor;
            InitializeComponent();
        }

        private void frmPacijentiInfo_Load(object sender, EventArgs e)
        {
            dgvDijagnoze.AutoGenerateColumns = false;
            LoadData();
            

        }
        private async Task LoadData()
        {
            await LoadGradovi();
            await LoadInfo();
            await LoadDijagnoze();
        }

        private async Task LoadInfo()
        {
            txtIme.Text= _pacijent.Ime;
            txtPrezime.Text = _pacijent.Prezime;
            txtTelefon.Text = _pacijent.Telefon;
            
        }

        private async Task LoadDijagnoze()
        {
            List<DijagnozaInfoModel> rezultat = await DijagnozaPacijentService.GetByDoktorId<List<DijagnozaInfoModel>>(_pacijent.Id);

            dgvDijagnoze.DataSource = rezultat;


            DataGridViewTextBoxColumn nazivKolona = new DataGridViewTextBoxColumn();
            nazivKolona.DataPropertyName = "DoktorIme";
            nazivKolona.HeaderText = "Ime doktora";
            nazivKolona.Width = 140;
            dgvDijagnoze.Columns.Add(nazivKolona);


            DataGridViewTextBoxColumn opisKolona = new DataGridViewTextBoxColumn();
            opisKolona.DataPropertyName = "Opis";
            opisKolona.HeaderText = "Opis dijagnoze";
            opisKolona.Width = 240;
            dgvDijagnoze.Columns.Add(opisKolona);

            DataGridViewTextBoxColumn datumKolona = new DataGridViewTextBoxColumn();
            datumKolona.DataPropertyName = "Datum";
            datumKolona.HeaderText = "Datum dijagnoze";
            datumKolona.Width = 140;
            dgvDijagnoze.Columns.Add(datumKolona);

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
            if (tab.SelectedIndex == 0)
            {
                PacijentUpdateRequest request = new PacijentUpdateRequest()
                {
                    Ime = txtIme.Text,
                    Prezime = txtPrezime.Text,
                    Telefon = txtTelefon.Text,
                };

                var grad = cblGradovi.SelectedItem as Grad;
                int gradId = grad.GradId;
                request.GradId = gradId;
                var pacijent = PacijentService.Put<PacijentUpdateRequest>(_pacijent.Id, request);

                if (pacijent != null)
                {
                    MessageBox.Show("Uspješno ste uredili podatke pacijenta.", "Success");
                    var forma = new Pacijent.frmPacijenti(_ordinacija, _doktor);
                    this.Hide();
                    forma.Closed += (s, args) => this.Show();
                    forma.ShowDialog();
                }
                else
                {
                    MessageBox.Show("Podaci se nisu mogli spremiti.", "Failure");
                }
            }
            if(tab.SelectedIndex ==2)
            {
                DijanozaInsertRequest dijagnoza = new DijanozaInsertRequest
                {
                    Datum = DateTime.Now,
                    DoktorId = _doktor.Id,
                    PacijentId = _pacijent.Id,
                    Opis = txtOpis.Text,
                };
                var novaDijagnoza = DijagnozaService.Post<DijanozaInsertRequest>(dijagnoza);
                if (novaDijagnoza != null)
                {
                    MessageBox.Show("Uspješno ste dodali novu dijagnoza pacijentu.", "Success");
                  
                }
                else
                {
                    MessageBox.Show("Podaci se nisu mogli spremiti.", "Failure");
                }
            }
        }

        private void btnBack_Click(object sender, EventArgs e)
        {
            var forma = new Pacijent.frmPacijenti(_ordinacija,_doktor);
            this.Hide();
            forma.Closed += (s, args) => this.Show();
            forma.ShowDialog();
        }

       

        private void tabPacijent_Click(object sender, EventArgs e)
        {

        }
    }
}
