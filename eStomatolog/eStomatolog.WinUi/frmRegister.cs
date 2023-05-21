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
    public partial class frmRegister : Form
    {
        public APIService KorisniciService { get; set; } = new APIService("Korisnik");
        public APIService RoleService { get; set; } = new APIService("Uloga");

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
                var roleList = clbUloge.CheckedItems.Cast<Uloge>().ToList();
                

                foreach(var role in roleList)
                {
                    if(role.Naziv=="Administrator")
                    {
                        role.UlogeID= 1;
                    }
                    else if(role.Naziv=="Korisnik")
                    {
                        role.UlogeID= 2;
                    }
                }
                var roleIdList = roleList.Select(x => x.UlogeID).ToList();
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
                        UlogeIdList = roleIdList,
                    };

                    var user = await KorisniciService.Register<Korisnik>(insertRequest);
                    MessageBox.Show("Uspješno ste dodali novog korisnika");

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
            var roles = await RoleService.Get<List<Uloge>>();
            clbUloge.DataSource = roles;
            clbUloge.DisplayMember = "Naziv";
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
