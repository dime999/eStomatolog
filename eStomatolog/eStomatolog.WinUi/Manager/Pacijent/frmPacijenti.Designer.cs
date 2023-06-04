namespace eStomatolog.WinUi.Manager.Pacijent
{
    partial class frmPacijenti
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
            this.dgvPacijenti = new System.Windows.Forms.DataGridView();
            this.label1 = new System.Windows.Forms.Label();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.txtIme = new System.Windows.Forms.TextBox();
            this.btnDodajNovogPacijenta = new System.Windows.Forms.Button();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvPacijenti)).BeginInit();
            this.groupBox2.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.dgvPacijenti);
            this.groupBox1.Location = new System.Drawing.Point(12, 67);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(609, 215);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Lista pacijenata";
            // 
            // dgvPacijenti
            // 
            this.dgvPacijenti.AllowUserToAddRows = false;
            this.dgvPacijenti.AllowUserToDeleteRows = false;
            this.dgvPacijenti.BackgroundColor = System.Drawing.SystemColors.ActiveCaption;
            this.dgvPacijenti.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvPacijenti.Location = new System.Drawing.Point(6, 22);
            this.dgvPacijenti.Name = "dgvPacijenti";
            this.dgvPacijenti.ReadOnly = true;
            this.dgvPacijenti.RowTemplate.Height = 25;
            this.dgvPacijenti.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvPacijenti.Size = new System.Drawing.Size(597, 184);
            this.dgvPacijenti.TabIndex = 0;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(15, 22);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(27, 15);
            this.label1.TabIndex = 2;
            this.label1.Text = "Ime";
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.txtIme);
            this.groupBox2.Controls.Add(this.label1);
            this.groupBox2.Location = new System.Drawing.Point(12, 12);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(609, 49);
            this.groupBox2.TabIndex = 3;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Filteri";
            // 
            // txtIme
            // 
            this.txtIme.BackColor = System.Drawing.SystemColors.InactiveCaption;
            this.txtIme.Location = new System.Drawing.Point(60, 19);
            this.txtIme.Name = "txtIme";
            this.txtIme.Size = new System.Drawing.Size(167, 23);
            this.txtIme.TabIndex = 3;
            // 
            // btnDodajNovogPacijenta
            // 
            this.btnDodajNovogPacijenta.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.btnDodajNovogPacijenta.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.btnDodajNovogPacijenta.ForeColor = System.Drawing.SystemColors.Control;
            this.btnDodajNovogPacijenta.Location = new System.Drawing.Point(18, 298);
            this.btnDodajNovogPacijenta.Name = "btnDodajNovogPacijenta";
            this.btnDodajNovogPacijenta.Size = new System.Drawing.Size(138, 23);
            this.btnDodajNovogPacijenta.TabIndex = 1;
            this.btnDodajNovogPacijenta.Text = "Dodaj novog pacijenta";
            this.btnDodajNovogPacijenta.UseVisualStyleBackColor = false;
            // 
            // frmPacijenti
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(633, 333);
            this.Controls.Add(this.btnDodajNovogPacijenta);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.Name = "frmPacijenti";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "frmPacijenti";
            this.Load += new System.EventHandler(this.frmPacijenti_Load);
            this.groupBox1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvPacijenti)).EndInit();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.DataGridView dgvPacijenti;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.TextBox txtIme;
        private System.Windows.Forms.Button btnDodajNovogPacijenta;
    }
}