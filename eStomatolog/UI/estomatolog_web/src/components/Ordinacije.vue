<template>
    <div class="ordinacije">
      <div class="ordinacija-card" v-for="(ordinacija, index) in ordinacije" :key="index">
        <div class="ordinacija-slika" :style="{ backgroundImage: 'url(' + ordinacija.slika + ')' }"></div>
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
        ordinacije: []
      };
    },
    mounted() {
      this.dohvatiOrdinacije();
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
      }
    }
  };
  </script>
  
  <style scoped>
  .ordinacije {
    display: flex;
    flex-wrap: wrap;
  }
  
  .ordinacija-card {
    width: 300px;
    margin: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    overflow: hidden;
  }
  
  .ordinacija-slika {
    height: 200px;
    background-size: cover;
    background-position: center;
  }
  
  .ordinacija-info {
    padding: 10px;
  }
  
  .ordinacija-info h3 {
    margin-top: 0;
  }
  
  </style>
  