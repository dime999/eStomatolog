namespace eStomatolog.WinUi.Manager
{
    partial class frmOrdinacija
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
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.txtTelefon = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.cbGradovi = new System.Windows.Forms.ComboBox();
            this.txtAddress = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.txtIme = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.btnSave = new System.Windows.Forms.Button();
            this.btnDoktori = new System.Windows.Forms.Button();
            this.btnRezervacije = new System.Windows.Forms.Button();
            this.btnReports = new System.Windows.Forms.Button();
            this.btnLoyalty = new System.Windows.Forms.Button();
            this.btnOcjene = new System.Windows.Forms.Button();
            this.btnSlike = new System.Windows.Forms.Button();
            this.btnCategories = new System.Windows.Forms.Button();
            this.btnServices = new System.Windows.Forms.Button();
            this.panel1 = new System.Windows.Forms.Panel();
            this.panel2 = new System.Windows.Forms.Panel();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.panel3 = new System.Windows.Forms.Panel();
            this.label5 = new System.Windows.Forms.Label();
            this.btnBack = new System.Windows.Forms.Button();
            this.groupBox1.SuspendLayout();
            this.panel1.SuspendLayout();
            this.panel2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.panel3.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.txtTelefon);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Controls.Add(this.label4);
            this.groupBox1.Controls.Add(this.cbGradovi);
            this.groupBox1.Controls.Add(this.txtAddress);
            this.groupBox1.Controls.Add(this.label3);
            this.groupBox1.Controls.Add(this.txtIme);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Location = new System.Drawing.Point(288, 140);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(768, 469);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Osnovne informacije";
            this.groupBox1.Enter += new System.EventHandler(this.groupBox1_Enter);
            // 
            // txtTelefon
            // 
            this.txtTelefon.Location = new System.Drawing.Point(6, 283);
            this.txtTelefon.Name = "txtTelefon";
            this.txtTelefon.Size = new System.Drawing.Size(249, 23);
            this.txtTelefon.TabIndex = 9;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(6, 247);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(45, 15);
            this.label2.TabIndex = 8;
            this.label2.Text = "Telefon";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(6, 190);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(32, 15);
            this.label4.TabIndex = 7;
            this.label4.Text = "Grad";
            // 
            // cbGradovi
            // 
            this.cbGradovi.FormattingEnabled = true;
            this.cbGradovi.Location = new System.Drawing.Point(6, 208);
            this.cbGradovi.Name = "cbGradovi";
            this.cbGradovi.Size = new System.Drawing.Size(249, 23);
            this.cbGradovi.TabIndex = 6;
            // 
            // txtAddress
            // 
            this.txtAddress.Location = new System.Drawing.Point(6, 147);
            this.txtAddress.Name = "txtAddress";
            this.txtAddress.Size = new System.Drawing.Size(249, 23);
            this.txtAddress.TabIndex = 5;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(6, 129);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(43, 15);
            this.label3.TabIndex = 4;
            this.label3.Text = "Adresa";
            // 
            // txtIme
            // 
            this.txtIme.Location = new System.Drawing.Point(6, 83);
            this.txtIme.Name = "txtIme";
            this.txtIme.Size = new System.Drawing.Size(249, 23);
            this.txtIme.TabIndex = 1;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(6, 57);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(36, 15);
            this.label1.TabIndex = 0;
            this.label1.Text = "Naziv";
            // 
            // btnSave
            // 
            this.btnSave.Location = new System.Drawing.Point(872, 625);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(174, 35);
            this.btnSave.TabIndex = 8;
            this.btnSave.Text = "Save changes";
            this.btnSave.UseVisualStyleBackColor = true;
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // btnDoktori
            // 
            this.btnDoktori.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.btnDoktori.FlatAppearance.BorderSize = 0;
            this.btnDoktori.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnDoktori.Font = new System.Drawing.Font("Segoe UI", 14F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.btnDoktori.ForeColor = System.Drawing.SystemColors.Control;
            this.btnDoktori.Location = new System.Drawing.Point(0, 126);
            this.btnDoktori.Name = "btnDoktori";
            this.btnDoktori.Size = new System.Drawing.Size(261, 49);
            this.btnDoktori.TabIndex = 1;
            this.btnDoktori.Text = "Doktori";
            this.btnDoktori.UseVisualStyleBackColor = false;
            this.btnDoktori.Click += new System.EventHandler(this.btnDoktori_Click);
            // 
            // btnRezervacije
            // 
            this.btnRezervacije.FlatAppearance.BorderSize = 0;
            this.btnRezervacije.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnRezervacije.Font = new System.Drawing.Font("Segoe UI", 14F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.btnRezervacije.ForeColor = System.Drawing.SystemColors.Control;
            this.btnRezervacije.Location = new System.Drawing.Point(0, 395);
            this.btnRezervacije.Name = "btnRezervacije";
            this.btnRezervacije.Size = new System.Drawing.Size(261, 49);
            this.btnRezervacije.TabIndex = 8;
            this.btnRezervacije.Text = "Rezervacije";
            this.btnRezervacije.UseVisualStyleBackColor = true;
            // 
            // btnReports
            // 
            this.btnReports.FlatAppearance.BorderSize = 0;
            this.btnReports.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnReports.Font = new System.Drawing.Font("Segoe UI", 14F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.btnReports.ForeColor = System.Drawing.SystemColors.Control;
            this.btnReports.Location = new System.Drawing.Point(0, 610);
            this.btnReports.Name = "btnReports";
            this.btnReports.Size = new System.Drawing.Size(261, 48);
            this.btnReports.TabIndex = 7;
            this.btnReports.Text = "Reports";
            this.btnReports.UseVisualStyleBackColor = true;
            // 
            // btnLoyalty
            // 
            this.btnLoyalty.FlatAppearance.BorderSize = 0;
            this.btnLoyalty.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnLoyalty.Font = new System.Drawing.Font("Segoe UI", 14F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.btnLoyalty.ForeColor = System.Drawing.SystemColors.Control;
            this.btnLoyalty.Location = new System.Drawing.Point(0, 467);
            this.btnLoyalty.Name = "btnLoyalty";
            this.btnLoyalty.Size = new System.Drawing.Size(261, 48);
            this.btnLoyalty.TabIndex = 6;
            this.btnLoyalty.Text = "Loyalty system";
            this.btnLoyalty.UseVisualStyleBackColor = true;
            // 
            // btnOcjene
            // 
            this.btnOcjene.FlatAppearance.BorderSize = 0;
            this.btnOcjene.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnOcjene.Font = new System.Drawing.Font("Segoe UI", 14F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.btnOcjene.ForeColor = System.Drawing.SystemColors.Control;
            this.btnOcjene.Location = new System.Drawing.Point(0, 329);
            this.btnOcjene.Name = "btnOcjene";
            this.btnOcjene.Size = new System.Drawing.Size(261, 48);
            this.btnOcjene.TabIndex = 4;
            this.btnOcjene.Text = "Reviews";
            this.btnOcjene.UseVisualStyleBackColor = true;
            // 
            // btnSlike
            // 
            this.btnSlike.FlatAppearance.BorderSize = 0;
            this.btnSlike.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnSlike.Font = new System.Drawing.Font("Segoe UI", 14F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.btnSlike.ForeColor = System.Drawing.SystemColors.Control;
            this.btnSlike.Location = new System.Drawing.Point(0, 535);
            this.btnSlike.Name = "btnSlike";
            this.btnSlike.Size = new System.Drawing.Size(261, 49);
            this.btnSlike.TabIndex = 3;
            this.btnSlike.Text = "Pictures";
            this.btnSlike.UseVisualStyleBackColor = true;
            // 
            // btnCategories
            // 
            this.btnCategories.FlatAppearance.BorderSize = 0;
            this.btnCategories.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnCategories.Font = new System.Drawing.Font("Segoe UI", 14F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.btnCategories.ForeColor = System.Drawing.SystemColors.Control;
            this.btnCategories.Location = new System.Drawing.Point(0, 260);
            this.btnCategories.Name = "btnCategories";
            this.btnCategories.Size = new System.Drawing.Size(261, 48);
            this.btnCategories.TabIndex = 2;
            this.btnCategories.Text = "Categories";
            this.btnCategories.UseVisualStyleBackColor = true;
            // 
            // btnServices
            // 
            this.btnServices.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.btnServices.FlatAppearance.BorderColor = System.Drawing.SystemColors.ActiveCaption;
            this.btnServices.FlatAppearance.BorderSize = 0;
            this.btnServices.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnServices.Font = new System.Drawing.Font("Segoe UI", 13F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.btnServices.ForeColor = System.Drawing.SystemColors.Control;
            this.btnServices.Location = new System.Drawing.Point(0, 195);
            this.btnServices.Name = "btnServices";
            this.btnServices.Size = new System.Drawing.Size(261, 49);
            this.btnServices.TabIndex = 5;
            this.btnServices.Text = "Pacijenti";
            this.btnServices.UseVisualStyleBackColor = false;
            this.btnServices.Click += new System.EventHandler(this.btnServices_Click);
            // 
            // panel1
            // 
            this.panel1.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.panel1.Controls.Add(this.btnReports);
            this.panel1.Controls.Add(this.btnRezervacije);
            this.panel1.Controls.Add(this.btnSlike);
            this.panel1.Controls.Add(this.btnLoyalty);
            this.panel1.Controls.Add(this.panel2);
            this.panel1.Controls.Add(this.btnDoktori);
            this.panel1.Controls.Add(this.btnServices);
            this.panel1.Controls.Add(this.btnOcjene);
            this.panel1.Controls.Add(this.btnCategories);
            this.panel1.Location = new System.Drawing.Point(0, 2);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(261, 711);
            this.panel1.TabIndex = 3;
            // 
            // panel2
            // 
            this.panel2.BackColor = System.Drawing.Color.SteelBlue;
            this.panel2.Controls.Add(this.pictureBox1);
            this.panel2.Location = new System.Drawing.Point(0, 0);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(261, 112);
            this.panel2.TabIndex = 0;
            // 
            // pictureBox1
            // 
            this.pictureBox1.Location = new System.Drawing.Point(0, 0);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(261, 112);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pictureBox1.TabIndex = 0;
            this.pictureBox1.TabStop = false;
            // 
            // panel3
            // 
            this.panel3.BackColor = System.Drawing.Color.LightSlateGray;
            this.panel3.Controls.Add(this.label5);
            this.panel3.Location = new System.Drawing.Point(261, 2);
            this.panel3.Name = "panel3";
            this.panel3.Size = new System.Drawing.Size(814, 112);
            this.panel3.TabIndex = 4;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Segoe UI", 25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.label5.ForeColor = System.Drawing.SystemColors.Control;
            this.label5.Location = new System.Drawing.Point(222, 32);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(446, 46);
            this.label5.TabIndex = 0;
            this.label5.Text = "eStomatolog Management";
            // 
            // btnBack
            // 
            this.btnBack.Location = new System.Drawing.Point(294, 625);
            this.btnBack.Name = "btnBack";
            this.btnBack.Size = new System.Drawing.Size(193, 39);
            this.btnBack.TabIndex = 9;
            this.btnBack.Text = "Back to previous screen";
            this.btnBack.UseVisualStyleBackColor = true;
            // 
            // frmOrdinacija
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1076, 676);
            this.Controls.Add(this.btnBack);
            this.Controls.Add(this.btnSave);
            this.Controls.Add(this.panel3);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.groupBox1);
            this.Name = "frmOrdinacija";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "eStomatolog Management";
            this.Load += new System.EventHandler(this.frmHairSalon_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.panel1.ResumeLayout(false);
            this.panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.panel3.ResumeLayout(false);
            this.panel3.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.TextBox txtIme;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox txtAddress;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.ComboBox cbGradovi;
        private System.Windows.Forms.Button btnDoktori;
        private System.Windows.Forms.Button btnCategories;
        private System.Windows.Forms.Button btnSlike;
        private System.Windows.Forms.Button btnLoyalty;
        private System.Windows.Forms.Button btnServices;
        private System.Windows.Forms.Button btnOcjene;
        private System.Windows.Forms.Button btnReports;
        private System.Windows.Forms.Button btnRezervacije;
        private System.Windows.Forms.Button btnSave;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.Panel panel3;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.Button btnBack;
        private TextBox txtTelefon;
        private Label label2;
    }
}