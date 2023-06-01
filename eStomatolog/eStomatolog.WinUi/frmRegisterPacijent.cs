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

namespace eStomatolog.WinUi
{
    public partial class frmRegisterPacijent : Form
    {
        public APIService KorisniciService { get; set; } = new APIService("Korisnik");
        public APIService OrdinacijaService { get; set; } = new APIService("Ordinacija");
        public APIService GradService { get; set; } = new APIService("Grad");

        private Korisnik _model = null;

        public frmRegisterPacijent(Korisnik model = null)
        {
            InitializeComponent();
            _model = model;
        }

        private async void btnSave_Click_1(object sender, EventArgs e)
        {

            if (ValidateChildren())
            {
               
                var ordinacijeList = clbOrdinacije.CheckedItems.Cast<Ordinacije>().ToList();
                var ordinacijaIdList = ordinacijeList.Select(x => x.OrdinacijaId).ToList();

                var grad = cblGradovi.SelectedItem as Grad;
                int gradId = grad.GradId;


                if (_model == null)
                {
                    KorisniciInsertRequest insertRequest = new KorisniciInsertRequest()
                    {
                        Ime = txtIme.Text,
                        Prezime = txtPrezime.Text,
                        Email = txtEmail.Text,
                        Telefon = txtTelefon.Text,
                        KorisnickoIme = txtUsername.Text,
                        DatumRodjenja = dtpDatum.Value,
                        Password = txtPassword.Text,
                        PasswordPotvrda = txtPasswordPotvrda.Text,
                        Status = chkStatus.Checked,
                        OrdinacijeIdList = ordinacijaIdList,
                        GradId = gradId,

                    };
                    insertRequest.UlogeIdList.Add(2);

                    var user = await KorisniciService.Register<Korisnik>(insertRequest);
                    MessageBox.Show("Uspješno ste dodali novog pacijenta");

                    this.Hide();
                    frmLogin login = new frmLogin();
                    login.Closed += Close;
                    login.Show();
                }
                else
                {
                    KorisniciUpdateRequest updateRequest = new KorisniciUpdateRequest()
                    {
                        Ime = txtIme.Text,
                        Prezime = txtPrezime.Text,
                       KorisnickoIme=txtUsername.Text,
                       Status= true,
                    };

                    _model = await KorisniciService.Put<Korisnik>(_model.KorisnikId, updateRequest);

                }
            }




        }
        private void Close(object sender, EventArgs e)
        {
            this.Close();
        }

        private void frmRegisterPacijent_Load(object sender, EventArgs e)
        {
            LoadOrdinacije();
            LoadGradovi();

            if (_model != null)
            {
                txtIme.Text = _model.Ime;
                txtPrezime.Text = _model.Prezime;
                txtEmail.Text = _model.Email;
                txtUsername.Text = _model.KorisnickoIme;
                chkStatus.Checked = _model.Status.GetValueOrDefault(false);
            }
        }



        private async Task LoadOrdinacije()
        {
            var ord = await OrdinacijaService.Get<List<Ordinacije>>();
            clbOrdinacije.DataSource = ord;
            clbOrdinacije.DisplayMember = "Naziv";
        }

        private async Task LoadGradovi()
        {
            var grad = await GradService.Get<List<Grad>>();
            cblGradovi.DataSource = grad;
            cblGradovi.DisplayMember = "Naziv";
            cblGradovi.ValueMember = "GradId";
        }


        private void txtIme_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtIme.Text))
            {
                e.Cancel = true;
                txtIme.Focus();
                errorProvider.SetError(txtIme, "Name should not be left blank!");
            }
            else
            {
                e.Cancel = false;
                errorProvider.SetError(txtIme, "");
            }
        }

        
    }
}
