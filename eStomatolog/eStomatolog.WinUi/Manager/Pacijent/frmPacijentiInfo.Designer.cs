namespace eStomatolog.WinUi.Manager.Pacijent
{
    partial class frmPacijentiInfo
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.btnBack = new System.Windows.Forms.Button();
            this.btnSave = new System.Windows.Forms.Button();
            this.tabDijagnoza = new System.Windows.Forms.TabPage();
            this.label3 = new System.Windows.Forms.Label();
            this.txtOpis = new System.Windows.Forms.TextBox();
            this.tabPregledi = new System.Windows.Forms.TabPage();
            this.tabPacijent = new System.Windows.Forms.TabPage();
            this.cblGradovi = new System.Windows.Forms.ComboBox();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.lblTelefon = new System.Windows.Forms.Label();
            this.txtTelefon = new System.Windows.Forms.TextBox();
            this.lblDatum = new System.Windows.Forms.Label();
            this.dtpDatum = new System.Windows.Forms.DateTimePicker();
            this.txtPrezime = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.txtIme = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.tab = new System.Windows.Forms.TabControl();
            this.dgvDijagnoze = new System.Windows.Forms.DataGridView();
            this.tabDijagnoza.SuspendLayout();
            this.tabPregledi.SuspendLayout();
            this.tabPacijent.SuspendLayout();
            this.groupBox1.SuspendLayout();
            this.tab.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvDijagnoze)).BeginInit();
            this.SuspendLayout();
            // 
            // btnBack
            // 
            this.btnBack.Location = new System.Drawing.Point(21, 352);
            this.btnBack.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnBack.Name = "btnBack";
            this.btnBack.Size = new System.Drawing.Size(99, 30);
            this.btnBack.TabIndex = 15;
            this.btnBack.Text = "Nazad";
            this.btnBack.UseVisualStyleBackColor = true;
            this.btnBack.Click += new System.EventHandler(this.btnBack_Click);
            // 
            // btnSave
            // 
            this.btnSave.Location = new System.Drawing.Point(489, 352);
            this.btnSave.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(99, 30);
            this.btnSave.TabIndex = 16;
            this.btnSave.Text = "Sačuvaj";
            this.btnSave.UseVisualStyleBackColor = true;
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // tabDijagnoza
            // 
            this.tabDijagnoza.Controls.Add(this.label3);
            this.tabDijagnoza.Controls.Add(this.txtOpis);
            this.tabDijagnoza.Location = new System.Drawing.Point(4, 24);
            this.tabDijagnoza.Name = "tabDijagnoza";
            this.tabDijagnoza.Padding = new System.Windows.Forms.Padding(3);
            this.tabDijagnoza.Size = new System.Drawing.Size(563, 283);
            this.tabDijagnoza.TabIndex = 2;
            this.tabDijagnoza.Text = "Dodaj dijagnozu";
            this.tabDijagnoza.UseVisualStyleBackColor = true;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(5, 16);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(202, 15);
            this.label3.TabIndex = 1;
            this.label3.Text = "Opišite trenutnu dijagnozu pacijenta:";
            // 
            // txtOpis
            // 
            this.txtOpis.Location = new System.Drawing.Point(6, 44);
            this.txtOpis.Multiline = true;
            this.txtOpis.Name = "txtOpis";
            this.txtOpis.Size = new System.Drawing.Size(551, 224);
            this.txtOpis.TabIndex = 0;
            // 
            // tabPregledi
            // 
            this.tabPregledi.Controls.Add(this.dgvDijagnoze);
            this.tabPregledi.Location = new System.Drawing.Point(4, 24);
            this.tabPregledi.Name = "tabPregledi";
            this.tabPregledi.Padding = new System.Windows.Forms.Padding(3);
            this.tabPregledi.Size = new System.Drawing.Size(563, 283);
            this.tabPregledi.TabIndex = 1;
            this.tabPregledi.Text = "Pregledi i nalazi";
            this.tabPregledi.UseVisualStyleBackColor = true;
            // 
            // tabPacijent
            // 
            this.tabPacijent.Controls.Add(this.cblGradovi);
            this.tabPacijent.Controls.Add(this.groupBox1);
            this.tabPacijent.Location = new System.Drawing.Point(4, 24);
            this.tabPacijent.Name = "tabPacijent";
            this.tabPacijent.Padding = new System.Windows.Forms.Padding(3);
            this.tabPacijent.Size = new System.Drawing.Size(563, 283);
            this.tabPacijent.TabIndex = 0;
            this.tabPacijent.Text = "Pacijent info";
            this.tabPacijent.UseVisualStyleBackColor = true;
            this.tabPacijent.Click += new System.EventHandler(this.tabPacijent_Click);
            // 
            // cblGradovi
            // 
            this.cblGradovi.FormattingEnabled = true;
            this.cblGradovi.Location = new System.Drawing.Point(20, 218);
            this.cblGradovi.Name = "cblGradovi";
            this.cblGradovi.Size = new System.Drawing.Size(121, 23);
            this.cblGradovi.TabIndex = 12;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.lblTelefon);
            this.groupBox1.Controls.Add(this.txtTelefon);
            this.groupBox1.Controls.Add(this.lblDatum);
            this.groupBox1.Controls.Add(this.dtpDatum);
            this.groupBox1.Controls.Add(this.txtPrezime);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Controls.Add(this.txtIme);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Location = new System.Drawing.Point(20, 36);
            this.groupBox1.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Padding = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.groupBox1.Size = new System.Drawing.Size(511, 157);
            this.groupBox1.TabIndex = 3;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Podaci";
            // 
            // lblTelefon
            // 
            this.lblTelefon.AutoSize = true;
            this.lblTelefon.Location = new System.Drawing.Point(14, 116);
            this.lblTelefon.Name = "lblTelefon";
            this.lblTelefon.Size = new System.Drawing.Size(48, 15);
            this.lblTelefon.TabIndex = 9;
            this.lblTelefon.Text = "Telefon:";
            // 
            // txtTelefon
            // 
            this.txtTelefon.Location = new System.Drawing.Point(177, 108);
            this.txtTelefon.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.txtTelefon.Name = "txtTelefon";
            this.txtTelefon.Size = new System.Drawing.Size(233, 23);
            this.txtTelefon.TabIndex = 8;
            // 
            // lblDatum
            // 
            this.lblDatum.AutoSize = true;
            this.lblDatum.Location = new System.Drawing.Point(14, 86);
            this.lblDatum.Name = "lblDatum";
            this.lblDatum.Size = new System.Drawing.Size(92, 15);
            this.lblDatum.TabIndex = 7;
            this.lblDatum.Text = "Datum rodjenja:";
            // 
            // dtpDatum
            // 
            this.dtpDatum.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dtpDatum.Location = new System.Drawing.Point(177, 80);
            this.dtpDatum.Name = "dtpDatum";
            this.dtpDatum.Size = new System.Drawing.Size(233, 23);
            this.dtpDatum.TabIndex = 6;
            // 
            // txtPrezime
            // 
            this.txtPrezime.Location = new System.Drawing.Point(177, 52);
            this.txtPrezime.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.txtPrezime.Name = "txtPrezime";
            this.txtPrezime.Size = new System.Drawing.Size(233, 23);
            this.txtPrezime.TabIndex = 3;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(14, 50);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(52, 15);
            this.label2.TabIndex = 2;
            this.label2.Text = "Prezime:";
            // 
            // txtIme
            // 
            this.txtIme.Location = new System.Drawing.Point(177, 25);
            this.txtIme.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.txtIme.Name = "txtIme";
            this.txtIme.Size = new System.Drawing.Size(233, 23);
            this.txtIme.TabIndex = 1;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(14, 26);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(30, 15);
            this.label1.TabIndex = 0;
            this.label1.Text = "Ime:";
            // 
            // tab
            // 
            this.tab.Controls.Add(this.tabPacijent);
            this.tab.Controls.Add(this.tabPregledi);
            this.tab.Controls.Add(this.tabDijagnoza);
            this.tab.Location = new System.Drawing.Point(21, 12);
            this.tab.Name = "tab";
            this.tab.SelectedIndex = 0;
            this.tab.Size = new System.Drawing.Size(571, 311);
            this.tab.TabIndex = 0;
            // 
            // dgvDijagnoze
            // 
            this.dgvDijagnoze.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvDijagnoze.Location = new System.Drawing.Point(6, 6);
            this.dgvDijagnoze.Name = "dgvDijagnoze";
            this.dgvDijagnoze.RowTemplate.Height = 25;
            this.dgvDijagnoze.Size = new System.Drawing.Size(551, 271);
            this.dgvDijagnoze.TabIndex = 0;
            // 
            // frmPacijentiInfo
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(608, 420);
            this.Controls.Add(this.btnSave);
            this.Controls.Add(this.btnBack);
            this.Controls.Add(this.tab);
            this.Name = "frmPacijentiInfo";
            this.Text = "frmPacijentiInfo";
            this.Load += new System.EventHandler(this.frmPacijentiInfo_Load);
            this.tabDijagnoza.ResumeLayout(false);
            this.tabDijagnoza.PerformLayout();
            this.tabPregledi.ResumeLayout(false);
            this.tabPacijent.ResumeLayout(false);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.tab.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvDijagnoze)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion
        private Button btnBack;
        private Button btnSave;
        private TabPage tabDijagnoza;
        private Label label3;
        private TextBox txtOpis;
        private TabPage tabPregledi;
        private TabPage tabPacijent;
        private ComboBox cblGradovi;
        private GroupBox groupBox1;
        private Label lblTelefon;
        private TextBox txtTelefon;
        private Label lblDatum;
        private DateTimePicker dtpDatum;
        private TextBox txtPrezime;
        private Label label2;
        private TextBox txtIme;
        private Label label1;
        private TabControl tab;
        private DataGridView dgvDijagnoze;
    }
}