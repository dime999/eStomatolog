<template>
  <div class="ordinacije" :style="{ top: topOffset }" :class="{ 'no-scroll': bodyOverflow }">
    <div class="ordinacije-info">
      <h2>Pogledajte detalje o našim ordinacijama</h2>
    </div>
    <div class="ordinacije-cards">
      <div class="ordinacija-card" v-for="(ordinacija, index) in ordinacije" :key="index"
        @click="showDetails(ordinacija)">
        <div :class="'ordinacija-slika' + index"></div>
        <div class="ordinacija-info">
          <h3>{{ ordinacija.naziv }}</h3>
          <p>{{ ordinacija.adresa }}</p>
          <p>{{ ordinacija.telefon }}</p>
        </div>
      </div>
    </div>
    <PopUp v-if="isPopupOpen" :ordinacija="selectedOrdinacija" :slike="ordinacijeSlikeIds" :isOrdinacija="true"
      @close="closePopup" />
  </div>
</template>

<script>
import PopUp from '../components/PupUp.vue'

export default {
  name: 'OrdinacijeBar',
  components: {
    PopUp
  },
  data() {
    return {
      ordinacije: [],
      topOffset: '60px',
      isPopupOpen: false,
      selectedOrdinacija: null,
      ordinacijeSlikeIds: [],
      bodyOverflow: false
    };
  },
  mounted() {
    this.dohvatiOrdinacije();
    window.addEventListener('scroll', this.handleScroll);
  },
  beforeUnmount() {
    window.removeEventListener('scroll', this.handleScroll);
  },
  methods: {
    async dohvatiOrdinacije() {
      try {
        const response = await fetch('http://localhost:7265/Ordinacija');
        const data = await response.json();
        this.ordinacije = data;
      } catch (error) {
        console.error('Greška pri dohvatu ordinacija:', error);
      }
    },
    handleScroll() {
      this.topOffset = window.pageYOffset > 60 ? '0' : '60px';
    },
    async showDetails(ordinacija) {

      this.selectedOrdinacija = ordinacija;
      try {
        const response = await fetch(`http://localhost:7265/OrdinacijaSlikeIds?ordinacijaId=${this.selectedOrdinacija.ordinacijaId}`);
        const data = await response.json();
        this.ordinacijeSlikeIds = data;
      } catch (error) {
        console.error('Greška pri dohvatu ordinacija:', error);
      }
      this.isPopupOpen = true;
      this.bodyOverflow = true;
    },
    closePopup() {
      this.isPopupOpen = false;
      this.bodyOverflow = false;
    }
  }
};
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap');

* {
  font-family: 'Montserrat', sans-serif;
  box-sizing: border-box;
}

.no-scroll {
  overflow: hidden !important;
    height: 100vh; 
}


.popup-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  z-index: 999;
}

.popup {
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background-color: white;
  padding: 20px;
  border-radius: 5px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
  z-index: 1000;
}

.ordinacije {
  display: flex;
  flex-direction: column;
  align-items: center;
  position: relative;
  width: 100%;
  top: 100%;
  left: 0;
  z-index: 1;
  transition: top 0.3s ease;
  margin-bottom: 50px;
}

.ordinacije-info {
  text-align: center;
  margin-bottom: 20px;
}

h2 {
  font-size: 4rem;
  font-weight: bold;
  color: white;
  text-shadow: 4px 4px 0px rgba(0, 0, 0, 0.8);
  margin-bottom: 10px;
  margin-top: 20px;
}

h3 {
  font-size: 3rem;
  font-weight: bold;
  color: white;
  text-shadow: 4px 4px 0px rgba(0, 0, 0, 0.8);
  margin-bottom: 10px;
  margin-top: 20px;
}

p {
  font-size: 2rem;
  font-weight: bold;
  color: white;
  text-shadow: 4px 4px 0px rgba(0, 0, 0, 0.8);
  margin-bottom: 10px;
  margin-top: 20px;
}

.ordinacije-cards {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
  width: 100%;
  margin-top: 100px;
}

.ordinacija-slika0 {
  height: 250px;
  background-image: url('../../public/klinika1.jpg');
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
}

.ordinacija-slika1 {
  height: 250px;
  background-image: url('../../public/klinika2.jpg');
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
}

.ordinacija-slika2 {
  height: 250px;
  background-image: url('../../public/klinika3.jpg');
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
}

.ordinacija-card {
  width: calc(20% - 20px);
  margin: 10px;
  border-radius: 10px;
  overflow: hidden;
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}

.ordinacija-info {
  padding: 25px;
  margin-top: 20px;
  margin-bottom: 20px;
}

.ordinacija-info h3 {
  margin-top: 0;
}
</style>
