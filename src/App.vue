<template>
  <div id="app">
    <md-toolbar class="md-dense">
      <h3 class="md-title" style="flex: 1">Super Bowl Squares</h3>
      <md-button class="md-raised md-primary" @click="choose(10)">10 Pool</md-button>
      <md-button class="md-raised md-primary" @click="choose(25)">25 Pool</md-button>
    </md-toolbar>
    <div v-if="loading">
      <md-progress-spinner :md-diameter="100" :md-stroke="10" md-mode="indeterminate">
      </md-progress-spinner>
      <h3 clas="md-title">Loading</h3>
    </div>
    <md-card v-if="!choice">
      <md-card-header>
        <div class="md-title">Welcome</div>
      </md-card-header>

      <md-card-content>
        You can select a pool on the top, then once in a pool you can click each user square to
        bring up that users scores.
      </md-card-content>
      <md-card-content>
        The refresh and winners button will become active after the start of the game.
      </md-card-content>
    </md-card>
    <SquaresBoard v-if="choice" :gameDay="gameDay" :pool="choice" :picks="picks"
                  :afc="afc" :nfc="nfc" :scores="scores"></SquaresBoard>
  </div>
</template>

<script>
import axios from 'axios';
import moment from 'moment-timezone';
import SquaresBoard from './components/SquaresBoard.vue';

const API_PATH = 'https://api.db94.io/squar';

export default {
  name: 'App',
  components: {
    SquaresBoard,
  },
  data() {
    return {
      choice: null,
      loading: false,
      scores: [],
      picks: {},
      gameDay: moment.now() < moment.tz('2019-02-03T13:00:00', 'America/Los_Angeles'),
      afc: {},
      nfc: {},
    };
  },
  methods: {
    choose(choice) {
      this.choice = null;
      this.loading = true;
      axios.get(`${API_PATH}/picks/${choice}`).then((response) => {
        this.picks = response.data.picks;
        this.afc = response.data.afc;
        this.nfc = response.data.nfc;
        this.choice = choice;
        this.loading = false;
        if (!this.gameDay) {
          axios.get(`${API_PATH}/scores`).then((scoreResponse) => {
            this.scores = scoreResponse.data.scores;
          });
        }
      });
    },
  },
};
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  max-height: 100vh;
}

.divider {
  border: 1px solid var(--md-theme-default-divider-on-background, rgba(255,255,255,0.12));
  text-align: center;
}

.thickBottom {
  border-bottom: 1px solid var(--md-theme-default-divider-on-background, rgba(255,255,255,0.5));
}
.thickRight {
  border-right: 1px solid var(--md-theme-default-divider-on-background, rgba(255,255,255,0.5));
}
</style>
