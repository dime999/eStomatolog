<template>
    <div class="popup-overlay" @click="closePopup"></div>
    <div class="popup-large">
      <div class="detail" style="margin-top: 100px;">
        <span>Naziv:</span>&nbsp;&nbsp; <h5 class="popup-heading">{{ ordinacija.naziv }}</h5>
      </div>
      <div class="detail">
        <span>Adresa:</span>&nbsp;&nbsp; <p class="popup-text">{{ ordinacija.adresa }}</p>
      </div>
      <div class="detail">
        <span>Telefon:</span>&nbsp;&nbsp; <p class="popup-text">{{ ordinacija.telefon }}</p>
      </div>
      <div class="detail">
        <p class="popup-text"><strong>Radno vrijeme: 8:00 - 16:00</strong></p>
      </div>
  
      <div class="image-container">
      <div class="content">
        <div class="slider">
          <img :src="currentImage" alt="Slika">
        </div>
        <div class="controls">
          <button @click="moveForward" :disabled="currentIndex === slike.length - 1">Naprijed</button>
          <button @click="moveBackward" :disabled="currentIndex === 0">Nazad</button>
        </div>
      </div>
    </div>
    
  
      <button class="close-button" @click="closePopup">Zatvori</button>
    </div>
  </template>
  
  <script>
  export default {
    name: 'PopUp',
    props: {
      ordinacija: Object,
      slike: Array
    },
    data() {
      return {
        currentIndex: 0,
        currentImage: '',
        loaded: false
      };
    },
    async mounted() {
      await this.getSLike(this.slike.slikeIds[this.currentIndex]);
    },
    methods: {
      closePopup() {
        this.$emit('close');
      },
      async getSLike(id) {
        try {
          const response = await fetch(`http://localhost:7265/SlikaStream?slikaId=${id}`);
          const blob = await response.blob();
          console.log(1);
          this.currentImage = URL.createObjectURL(blob);
          this.loaded = true;
          console.log(2);
        } catch (error) {
          console.error('Greška pri dohvatu slike:', error);
        }
      },
      async moveForward() {
        if (this.currentIndex < this.slike.length - 1) {
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

  .popup-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5); 
    z-index: 999;
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
    z-index: 1000;
    width: 50%;
    height: 50%; 
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
  margin: 0 10px;
}

.close-button {
  background-color: #ff5959;
  color: white;
  border: none;
  border-radius: 5px;
  padding: 10px 20px;
  cursor: pointer;
  width: 20%;
  margin-top: 140px; 
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}
.close-button:hover {
  background-color: #ff4040; 
}
  </style>
  