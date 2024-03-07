<template>
    <div class="doktori" :style="{ top: topOffset }" :class="{ 'no-scroll': bodyOverflow }">
        <div class="doktori-info">
            <h2>Pogledajte detalje o našim doktorima</h2>
        </div>
        <div class="doktori-cards">
            <div class="doktori-card" v-for="(doktor, index) in doktori" :key="index" @click="showDetails(doktor)">
                <div class="doktori-slika"></div>
                <div class="doktori-info">
                    <h3>{{ doktor.ime }}</h3>
                    <p>{{ doktor.prezime }}</p>
                </div>
            </div>
        </div>
        <PopUp v-if="isPopupOpen" :ordinacija="selectedDoktor" :isDoktor="true" :doktor="selectedDoktor"
            @close="closePopup" />
    </div>
</template>

<script>
import PopUp from '../components/PupUp.vue'

export default {
    name: 'DoktoriBar',
    components: {
        PopUp
    },
    data() {
        return {
            doktori: [],
            topOffset: '60px',
            isPopupOpen: false,
            selectedDoktor: null,
            bodyOverflow: false
        };
    },
    mounted() {
        this.dohvatiDoktore();
        window.addEventListener('scroll', this.handleScroll);
    },
    beforeUnmount() {
        window.removeEventListener('scroll', this.handleScroll);
    },
    methods: {
        async dohvatiDoktore() {
            try {
                const response = await fetch('http://localhost:7265/Doktor');
                const data = await response.json();
                this.doktori = data;
            } catch (error) {
                console.error('Greška pri dohvatu ordinacija:', error);
            }
        },
        handleScroll() {
            this.topOffset = window.pageYOffset > 60 ? '0' : '60px';
        },
        async showDetails(doktor) {

            this.selectedDoktor = doktor;
            this.isPopupOpen = true;
            this.bodyOverflow = true;
            const ordinacijaElements = document.getElementsByClassName('ordinacije');
            const welcomeSectionElements = document.getElementsByClassName('welcome-section');

            if (ordinacijaElements.length > 0) {
                for (const elem of ordinacijaElements) {
                    elem.style.zIndex = '-1';
                }
            }

            if (welcomeSectionElements.length > 0) {
                for (const elem of welcomeSectionElements) {
                    elem.style.zIndex = '-1';
                }
            }
        },
        closePopup() {
            this.isPopupOpen = false;
            this.bodyOverflow = false;
            const ordinacijaElements = document.getElementsByClassName('ordinacije');
            const welcomeSectionElements = document.getElementsByClassName('welcome-section');

            if (ordinacijaElements.length > 0) {
                for (const elem of ordinacijaElements) {
                    elem.style.zIndex = '1';
                }
            }

            if (welcomeSectionElements.length > 0) {
                for (const elem of welcomeSectionElements) {
                    elem.style.zIndex = '1';
                }
            }
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

.doktori {
    display: flex;
    flex-direction: column;
    align-items: center;
    position: relative;
    width: 100%;
    top: 100%;
    left: 0;
    z-index: 0;
    transition: top 0.3s ease;
    margin-bottom: 50px;
    padding-top: 50px;
    margin-top: 260px;
}

.doktori-info {
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

.doktori-cards {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-around;
    width: 100%;
    margin-top: 100px;
}



.doktori-card {
    width: calc(20% - 20px);
    margin: 10px;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}

.doktori-info {
    padding: 25px;
    margin-top: 20px;
    margin-bottom: 20px;
    z-index: -1;
}

.doktori-info h3 {
    margin-top: 0;
}

.doktori-slika {
    height: 300px;
    background-image: url('../../public/lista_doktor.png');

    background-size: contain;
    background-position: center;
    background-repeat: no-repeat;
}

@media screen and (max-width: 768px) {

  .doktori-card {
    width: calc(50% - 20px);
  }

  h2 {
  font-size: 1rem;
  font-weight: bold;
  color: white;
  text-shadow: 1px 1px 0px rgba(0, 0, 0, 0.8);
  margin-bottom: 10px;
  margin-top: 20px;
}

h3 {
  font-size: 1rem;
  font-weight: bold;
  color: white;
  text-shadow: 1px 1px 0px rgba(0, 0, 0, 0.8);
  margin-bottom: 10px;
  margin-top: 20px;
}

p {
  font-size: 1rem;
  font-weight: bold;
  color: white;
  text-shadow: 1px 1px 0px rgba(0, 0, 0, 0.8);
  margin-bottom: 10px;
  margin-top: 20px;
}
}
</style>