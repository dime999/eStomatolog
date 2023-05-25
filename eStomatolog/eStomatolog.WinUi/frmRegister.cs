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
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace eStomatolog.WinUi
{
    public partial class frmRegister : Form
    {
        public APIService KorisniciService { get; set; } = new APIService("Korisnik");
        public APIService SpecService { get; set; } = new APIService("Specijalizacija");
        public APIService OrdinacijaService { get; set; } = new APIService("Ordinacija");
        public APIService GradService { get; set; } = new APIService("Grad");

        private Korisnik _model = null;

        public frmRegister(Korisnik model = null)
        {
            InitializeComponent();
            _model = model;
        }

        private async void btnSave_Click(object sender, EventArgs e)
        {

            if (ValidateChildren())
            {
                var roleList = clbUloge.CheckedItems.Cast<Specijalizacija>().ToList();
                var ordinacijeList = clbOrdinacije.CheckedItems.Cast<Ordinacija>().ToList();
               
                var roleIdList = roleList.Select(x => x.SpecijalizacijaId).ToList();
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
                        Telefon = "test",
                        KorisnickoIme = txtUsername.Text,
                        Password = txtPassword.Text,
                        PasswordPotvrda = txtPasswordPotvrda.Text,
                        Status = chkStatus.Checked,                  
                        SpecijalizacijeIdList= roleIdList,
                        OrdinacijeIdList= ordinacijaIdList,
                        GradId= gradId,
                        
                    };
                    insertRequest.UlogeIdList.Add(1);

                    var user = await KorisniciService.Register<Korisnik>(insertRequest);
                    MessageBox.Show("Uspješno ste dodali novog doktora");

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
                        Email = txtEmail.Text,
                        Password = txtPassword.Text,
                        PasswordPotvrda = txtPasswordPotvrda.Text,
                        Status = chkStatus.Checked,
                    };

                    _model = await KorisniciService.Put<Korisnik>(_model.KorisnikId, updateRequest);

                }
            }




        }
        private void Close(object sender, EventArgs e)
        {
            this.Close();
        }

        private async void frmKorisniciDetails_Load(object sender, EventArgs e)
        {
            await LoadRoles();
            await LoadOrdinacije();
            await LoadGradovi();

            if (_model != null)
            {
                txtIme.Text = _model.Ime;
                txtPrezime.Text = _model.Prezime;
                txtEmail.Text = _model.Email;
                txtUsername.Text = _model.KorisnickoIme;
                chkStatus.Checked = _model.Status.GetValueOrDefault(false);
            }
        }

        private async Task LoadRoles()
        {
            var spec = await SpecService.Get<List<Specijalizacija>>();
            clbUloge.DataSource = spec;
            clbUloge.DisplayMember = "Naziv";
        }

        private async Task LoadOrdinacije()
        {
            var ord = await OrdinacijaService.Get<List<Ordinacija>>();
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
