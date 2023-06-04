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

namespace eStomatolog.WinUi.Manager.Doktori
{
    public partial class frmDoktoriAdd : Form
    {

        private Ordinacije _ordinacija { get; set; }
        private Doktor _user { get; set; }

        public APIService KorisniciService { get; set; } = new APIService("Korisnik");
        public APIService SpecService { get; set; } = new APIService("Specijalizacija");
        public APIService GradService { get; set; } = new APIService("Grad");

        public frmDoktoriAdd(Ordinacije ordinacija, Doktor user)
        {
            _ordinacija = ordinacija;
            _user = user;
            InitializeComponent();
        }

        private void frmDoktoriAdd_Load(object sender, EventArgs e)
        {
            LoadData();
        }

        private async Task LoadData()
        {
            await LoadRoles();
            await LoadGradovi();
        }

       
      

        private async Task LoadRoles()
        {
            var spec = await SpecService.Get<List<Specijalizacija>>();
            clbSpecijalizacije.DataSource = spec;
            clbSpecijalizacije.DisplayMember = "Naziv";
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

        private void btnBack_Click(object sender, EventArgs e)
        {
            this.Hide();
            frmDoktori frm = new frmDoktori(_ordinacija,_user);
            frm.Closed += Close;
            frm.Show();
        }
        private void Close(object sender, EventArgs e)
        {
            this.Close();
        }

        private async void btnSave_Click(object sender, EventArgs e)
        {
            if (ValidateChildren())
            {
                var roleList = clbSpecijalizacije.CheckedItems.Cast<Specijalizacija>().ToList();
                var roleIdList = roleList.Select(x => x.SpecijalizacijaId).ToList();
                var ordinacijaId = _ordinacija.OrdinacijaId;

                var grad = cblGradovi.SelectedItem as Grad;
                int gradId = grad.GradId;


               
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
                        SpecijalizacijeIdList = roleIdList,
                        GradId = gradId,

                    };
                    insertRequest.UlogeIdList.Add(1);
                    insertRequest.OrdinacijeIdList.Add(ordinacijaId);

                    var user = await KorisniciService.Register<Korisnik>(insertRequest);
                    MessageBox.Show("Uspješno ste dodali novog doktora");

                    this.Hide();
                    frmDoktori frm = new frmDoktori(_ordinacija,_user);
                    frm.Closed += Close;
                    frm.Show();
                }
               
            }

        private void btnBack_Click_1(object sender, EventArgs e)
        {
            this.Hide();
            frmDoktori frm = new frmDoktori(_ordinacija, _user);
            frm.Closed += Close;
            frm.Show();
        }
    }
}
