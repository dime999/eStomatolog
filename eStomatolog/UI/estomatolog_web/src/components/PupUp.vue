<template>
  <div class="popup-overlay" @click="closePopup"></div>
  <div class="popup-large">
    <div v-show="isOrdinacija" class="detail" style="margin-top: 100px;">
      <span>Naziv:</span>&nbsp;&nbsp; <h5 class="popup-heading">{{ ordinacija.naziv }}</h5>
    </div>
    <div v-show="isOrdinacija" class="detail">
      <span>Adresa:</span>&nbsp;&nbsp; <p class="popup-text">{{ ordinacija.adresa }}</p>
    </div>
    <div v-show="isOrdinacija" class="detail">
      <span>Telefon:</span>&nbsp;&nbsp; <p class="popup-text">{{ ordinacija.telefon }}</p>
    </div>
    <div v-show="isOrdinacija" class="detail" style="position: absolute; bottom: 20px; left: 50%; transform: translateX(-50%);">
      <p class="popup-text"><strong>Radno vrijeme: 8:00 - 16:00</strong></p>
    </div>
   

    <div v-show="isDoktor" class="detail" style="margin-bottom: 50px; margin-left: 30%;">
      <span>Detaljne informacije doktora</span>
    </div>
    <div v-show="isDoktor" class="detail">
      <span>Ime i prezime:</span>&nbsp;&nbsp; <p class="popup-text">{{ doktor.ime }} {{ doktor.prezime }}</p>
    </div>
    <div v-show="isDoktor" class="detail" style="margin-top: 30px;">
  <span style="margin-right: 10px;
  font-weight: bold;
  font-size: 25px;">Specijalizacije</span>
   <div class="specijalizacije-container">
    <div v-for="(specijalizacija, index) in specijalizacije" :key="index" :class="['specijalizacija', specijalizacija.hasSpecijalizacija ? 'green-bg' : 'red-bg']">
      <p>{{ specijalizacija.naziv }}</p>
    </div>
  </div>
</div>

    <div v-show="isDoktor" class="image-container">
      <div class="content">
        <div class="doktori-slika"></div>
      </div>
    </div>

    <div v-show="isOrdinacija" class="image-container">
      <div class="content">
        <div class="slider">
          <img :src="currentImage" alt="Slika" class="image-frame">
        </div>
        <div class="controls">
          <button class="nav-button" @click="moveBackward" :disabled="currentIndex === 0">
            <i class="fas fa-arrow-left"></i>
          </button>
          <button class="nav-button" @click="moveForward" :disabled="currentIndex === slike.length - 1">
            <i class="fas fa-arrow-right"></i>
          </button>
        </div>

      </div>
    </div>


    <button class="close-button" @click="closePopup">
      <i class="fas fa-times"></i> 
    </button>
  </div>
</template>

<script>
import '@fortawesome/fontawesome-free/css/all.css'

export default {
  name: 'PopUp',
  props: {
    ordinacija: {
      type: Object,
      required: false,
      default: () => ({})
    },
    doktor: {
      type: Object,
      required: false,
      default: () => ({})
    },
    slike: {
      type: Array,
      required: false,
      default: () => []
    },
    isOrdinacija: Boolean,
    isDoktor: Boolean,
    doktorSpecijalizacije: {
      type: Array,
      required: false,
      default: () => []
    },
  },
  data() {
    return {
      currentIndex: 0,
      currentImage: '',
      loaded: false,
      specijalizacije:[
  { "specijalizacijaId": 1, "naziv": "Oralna hirurgija", "hasSpecijalizacija":false },
  { "specijalizacijaId": 2, "naziv": "Endodoncija","hasSpecijalizacija":false },
  { "specijalizacijaId": 3, "naziv": "Ortodoncija","hasSpecijalizacija":false }
]

    };
  },
  async mounted() {
    if (this.isOrdinacija) {
      await this.getSLike(this.slike.slikeIds[this.currentIndex]);
    }
    else{
      this.checkSpecijalizacije();
    }
  },
  methods: {
    closePopup() {
      this.$emit('close');
    },
    checkSpecijalizacije() {
    this.doktorSpecijalizacije.forEach(doktorSpec => {
      this.specijalizacije.forEach(spec => {
        if (doktorSpec.specijalizacijaNaziv === spec.naziv) {
          spec.hasSpecijalizacija = true;
        }
      });
    });
    // Provera da li postoji bilo koja specijalizacija sa hasSpecijalizacija: true
    this.hasSpecijalizacija = this.specijalizacije.some(spec => spec.hasSpecijalizacija);
  },
    async getSLike(id) {
      try {
        const response = await fetch(`http://localhost:7265/SlikaStream?slikaId=${id}`);
        const blob = await response.blob();
        this.currentImage = URL.createObjectURL(blob);
        this.loaded = true;
      } catch (error) {
        console.error('Greška pri dohvatu slike:', error);
      }
    },
    async moveForward() {
      console.log(this.slike);
      console.log(this.slike.length);
      if (this.slike && this.currentIndex < this.slike.slikeIds.length - 1) {
        this.currentIndex++;
        await this.getSLike(this.slike.slikeIds[this.currentIndex]);
      }
    },
    async moveBackward() {
      if (this.currentIndex > 0) {
        this.currentIndex--;
        await this.getSLike(this.slike.slikeIds[this.currentIndex]);
      }
    }
  }
};
</script>

<style>
.specijalizacija.green-bg {
  background-color: rgba(0, 199, 0, 0.5); 
}

.specijalizacija.red-bg {
  background-color: rgba(255, 0, 0, 0.5); 
}
.popup-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  z-index: 9999;
}
.doktori-slika {
    height: 300px;
    background-image: url('../../public/lista_doktor.png');

    background-size: contain;
    background-position: center;
    background-repeat: no-repeat;
}
.popup-large {
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background-color: white;
  padding: 40px;
  border-radius: 10px;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
  z-index: 10000;
  width: 50%;
  height: 60%;
  max-height: 80%;
  overflow-y: auto;
}

.detail {
  margin-bottom: 20px;
  display: flex;
  align-items: flex-start;
}

.detail span {
  margin-right: 10px;
  font-weight: bold;
  font-size: 30px;
}

.popup-heading {
  font-size: 28px;
  margin: 0;
}

.popup-text {
  font-size: 26px;
  margin: 0;
}

.image-container {
  margin-right: 95px;
  width: 35%;
  position: absolute;
  right: 20px;
  top: 40%;
  transform: translateY(-50%);
  overflow: hidden;
  border: 2px solid #4e9af1;
  border-radius: 10px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}


.image-frame {
  width: 100%;
  border-radius: 8px;
}

.content {
  border: 1px solid #ccc;
}

.slider {
  position: relative;
}

.slider img {
  width: 100%;
}

.controls {
  margin-top: 10px;
  text-align: center;
}

.controls button {
  margin: 10px 10px;
}


.close-button {
  position: absolute;
  top: 10px;
  right: 10px;
  background-color: #ff5959;
  color: white;
  border: none;
  border-radius: 50%; 
  padding: 10px;
  cursor: pointer;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  z-index: 1001; 
}

.close-button:hover {
  background-color: #ff4040;
}

.nav-button {
  background-color: #4e9af1;
  color: white;
  border: none;
  border-radius: 5px;
  padding: 10px 15px;
  cursor: pointer;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.nav-button:hover {
  background-color: #3681d8;
}

.nav-button:disabled {
  cursor: not-allowed;
  opacity: 0.7;
}


.fa-arrow-left::before {
  content: "\f060";
}

.fa-arrow-right::before {
  content: "\f061";
}

.specijalizacije-container {
  display: flex;
  flex-wrap: wrap;
  justify-content: flex-start;
  margin-top: 60px;
  display: block;
  transform: translateX(-120%);
}

.specijalizacija {
  border: 2px solid #4e9af1;
  border-radius: 20px;
  padding: 5px 15px;
  margin-right: 10px;
  margin-bottom: 20px;
  background-color: #eaf6ff;
 
}


</style>