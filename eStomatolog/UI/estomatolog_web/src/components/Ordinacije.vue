<template>
   <div class="ordinacije" :style="{ top: topOffset }">
      <div class="ordinacija-card" v-for="(ordinacija, index) in ordinacije" :key="index">
        <div :class="'ordinacija-slika' + index"></div>

        <div class="ordinacija-info">
          <h3>{{ ordinacija.naziv }}</h3>
          <p>{{ ordinacija.adresa }}</p>
          <p>{{ ordinacija.telefon }}</p>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    name: 'OrdinacijeBar',
    data() {
      return {
        ordinacije: [],
        topOffset: '60px' 
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
      // Metoda za rukovanje skrolom
      this.topOffset = window.pageYOffset > 60 ? '0' : '60px'; 
    }
    }
  };
  </script>
  
  <style scoped>
  .ordinacije {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-around;
    background-color: white;
    position: relative; 
    width: 100%;
    top: 100%; 
    left: 0;
    z-index: 1;
    transition: top 0.3s ease;
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
    width: calc(20% - 20px); /* Širina trećine ekrana s razmakom od 20 piksela */
    margin: 10px;
    border: 1px solid #ccc;
    border-radius: 10px; /* Povećavamo radijus zaobljenja na karticama */
    overflow: hidden;
  }
  

  
  .ordinacija-info {
    padding: 15px; /* Povećavamo razmak između rubova kartice i sadržaja */
  }
  
  .ordinacija-info h3 {
    margin-top: 0;
  }
  </style>