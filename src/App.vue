<template>
  <div id="app">
    <md-toolbar class="md-dense">
      <md-button class="md-icon-button md-raised" @click="home()"><md-icon>home</md-icon></md-button>
      <md-button class="md-icon-button md-primary md-raised" v-if="choice" @click="showDialog = true"><md-icon>attach_money</md-icon></md-button>
      <md-button class="md-icon-button md-primary md-raised" @click="searchPage()"><md-icon>search</md-icon></md-button>
      <md-button class="md-raised md-primary" @click="choose('10')">$10</md-button>
      <md-button class="md-raised md-primary" @click="choose('25')">$25</md-button>
    </md-toolbar>
    <div v-if="loading">
      <md-progress-spinner :md-diameter="100" :md-stroke="10" md-mode="indeterminate">
      </md-progress-spinner>
      <h3 clas="md-title">Loading</h3>
    </div>
    <md-card v-if="search">
      <md-card-header>
        <div class="md-title">Search</div>
      </md-card-header>

      <md-card-content>
        <md-field>
          <label for="users">Choose Entries</label>
          <md-select v-model="selectedUsers" name="users" id="users" multiple>
            <md-option v-for="entry in entries" v-bind:key="entry" v-bind:value="entry">{{entry}}</md-option>
          </md-select>
        </md-field>

        <md-table v-for="user in selectedUsers" v-bind:key="user" md-card class="searchTable">
          <md-table-row>
            <md-table-head>Name</md-table-head>
            <md-table-head>Pool</md-table-head>
            <md-table-head>Q1</md-table-head>
            <md-table-head>Q2</md-table-head>
            <md-table-head>Q3</md-table-head>
            <md-table-head>2M</md-table-head>
            <md-table-head>Q4</md-table-head>
          </md-table-row>
          <md-table-row v-for="(picks, index) in pools.entries[user]['25']" v-bind:key="user + '25' + index">
            <md-table-cell>{{user}}</md-table-cell>
            <md-table-cell>$25</md-table-cell>
            <md-table-cell>TB: {{picks[0][0]}}, KC: {{picks[0][1]}}</md-table-cell>
            <md-table-cell>TB: {{picks[1][0]}}, KC: {{picks[1][1]}}</md-table-cell>
            <md-table-cell>TB: {{picks[2][0]}}, KC: {{picks[2][1]}}</md-table-cell>
            <md-table-cell>TB: {{picks[3][0]}}, KC: {{picks[3][1]}}</md-table-cell>
            <md-table-cell>TB: {{picks[4][0]}}, KC: {{picks[4][1]}}</md-table-cell>
          </md-table-row>

          <md-table-row v-for="(picks, index) in pools.entries[user]['10']" v-bind:key="user + '10' + index">
            <md-table-cell>{{user}}</md-table-cell>
            <md-table-cell>$10</md-table-cell>
            <md-table-cell>TB: {{picks[0][0]}}, KC: {{picks[0][1]}}</md-table-cell>
            <md-table-cell>TB: {{picks[1][0]}}, KC: {{picks[1][1]}}</md-table-cell>
            <md-table-cell>TB: {{picks[2][0]}}, KC: {{picks[2][1]}}</md-table-cell>
            <md-table-cell>TB: {{picks[3][0]}}, KC: {{picks[3][1]}}</md-table-cell>
            <md-table-cell>TB: {{picks[4][0]}}, KC: {{picks[4][1]}}</md-table-cell>
          </md-table-row>
        </md-table>
      </md-card-content>
    </md-card>
    <md-card v-if="!search && !choice">
      <md-card-header>
        <div class="md-title">Super Bowl Squares</div>
      </md-card-header>

      <md-card-content>
        <div class="md-subheading">How To Use</div>
        You can select a pools on the top, then once in a pool you can click each user square to
        bring up that users scores.<br/>
        The refresh and winners button will become active after the start of the game.<br/>
        Or choose the search icon and view just the picks you select.
      </md-card-content>

      <md-card-header>
        <div class="md-title">Mailing List</div>
      </md-card-header>
      <md-card-content>
        If you want to get the emails about superbowl squares next year please sign up for the mailing list. The email might go to your spam so make sure to check for the confirmation email there also.
        <form action="https://ml.kundenserver.de/cgi-bin/mailinglist.cgi" method="POST" target="_blank">
          <input checked name="subscribe_r" type="radio" value="subscribe">
          Yes, I want to become a member of the mailing list squares@db94.io.
          <br />
          <input name="subscribe_r" type="radio" value="unsubscribe">
          Please remove me from mailing list squares@db94.io.
          <br />
          Enter your email address:
          <br />
          <input maxlength="51" name="mailaccount_r" size="51" type="text">
          <br />
          Please confirm your email address:
          <br />
          <input maxlength="51" name="mailaccount2_r" size="51" type="text">
          <br />
          <input type="SUBMIT" value="Send">
          <br />
          <input type="RESET" value="Reset">
          <hr />
          <input name="FBMLNAME" type="hidden" value="squares@db94.io">
          <br />
          <input name="FBLANG" type="hidden" value="en">
          <br />
          <input name="FBURLERROR_L" type="hidden" value="https://ml.kundenserver.de/mailinglist/error.en.html">
          <br />
          <input name="FBURLSUBSCRIBE_L" type="hidden" value="https://ml.kundenserver.de/mailinglist/subscribe.en.html">
          <br />
          <input name="FBURLUNSUBSCRIBE_L" type="hidden" value="https://ml.kundenserver.de/mailinglist/unsubscribe.en.html">
          <br />
          <input name="FBURLINVALID_L" type="hidden" value="https://ml.kundenserver.de/mailinglist/invalid.en.html">
        </form>
      </md-card-content>
    </md-card>
    <md-card v-if="false">
      <md-card-content>
        <md-field>
          <label for="entries">Select Entries To Watch</label>
          <md-select v-model="selectedEntries" name="entries" multiple>
            <md-option v-for="entry in options" v-bind:value="entry" v-bind:key="entry">{{entry}}</md-option>
          </md-select>
        </md-field>
      </md-card-content>
    </md-card>
    <md-card v-if="selectedEntries.length > 0">
      <md-card-content>
        <md-card-header>
          <div class="md-title">$1 Pool</div>
        </md-card-header>
        <md-table>
          <md-table-row>
            <md-table-cell class="smaller">Quarter</md-table-cell>
            <md-table-cell>Winner</md-table-cell>
            <md-table-cell>Reverse</md-table-cell>
            <md-table-cell>Touching Winner</md-table-cell>
          </md-table-row>
        </md-table>
      </md-card-content>
    </md-card>
    <md-dialog :md-active.sync="showDialog">
      <md-dialog-title>Payouts</md-dialog-title>

      <md-card>
        <md-card-content>
          <md-table>
            <md-table-row>
              <md-table-cell class="smaller">Quarter</md-table-cell>
              <md-table-cell class="smaller">Winner</md-table-cell>
              <md-table-cell class="smaller">Reverse</md-table-cell>
              <md-table-cell class="smaller">Touching Winner</md-table-cell>
            </md-table-row>
            <md-table-row>
              <md-table-cell class="smaller">1st</md-table-cell>
              <md-table-cell class="smaller">${{8*num}}</md-table-cell>
              <md-table-cell class="smaller">${{2*num}}</md-table-cell>
              <md-table-cell class="smaller">${{1*num}}</md-table-cell>
            </md-table-row>
            <md-table-row>
              <md-table-cell class="smaller">2nd</md-table-cell>
              <md-table-cell class="smaller">${{12*num}}</md-table-cell>
              <md-table-cell class="smaller">${{4*num}}</md-table-cell>
              <md-table-cell class="smaller">${{1*num}}</md-table-cell>
            </md-table-row>
            <md-table-row>
              <md-table-cell class="smaller">3rd</md-table-cell>
              <md-table-cell class="smaller">${{14*num}}</md-table-cell>
              <md-table-cell class="smaller">${{2*num}}</md-table-cell>
              <md-table-cell class="smaller">${{1*num}}</md-table-cell>
            </md-table-row>
            <md-table-row>
              <md-table-cell class="smaller">2 min</md-table-cell>
              <md-table-cell class="smaller">${{4*num}}</md-table-cell>
              <md-table-cell class="smaller">N/A</md-table-cell>
              <md-table-cell class="smaller">N/A</md-table-cell>
            </md-table-row>
            <md-table-row>
              <md-table-cell class="smaller">Final</md-table-cell>
              <md-table-cell class="smaller">${{30*num}}</md-table-cell>
              <md-table-cell class="smaller">${{8*num}}</md-table-cell>
              <md-table-cell class="smaller">${{1*num}}</md-table-cell>
            </md-table-row>
          </md-table>
          <md-dialog-actions>
            <md-button class="md-primary" @click="showDialog = false">Close</md-button>
          </md-dialog-actions>
        </md-card-content>
      </md-card>
    </md-dialog>
    <SquaresBoard v-if="choice" :gameDay="gameDay" :pool="choice" :pools="pools[choice]" :scores="scores"></SquaresBoard>
  </div>
</template>

<script>
import axios from 'axios';
import moment from 'moment-timezone';
import SquaresBoard from './components/SquaresBoard.vue';

const API_PATH = 'https://api.db94.io/squares';

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
      pools: {},
      picks: {},
      gameDay: moment.now() < moment.tz('2021-02-07T13:00:00', 'America/Los_Angeles'),
      afc: {},
      nfc: {},
      selectedEntries: [],
      showDialog: false,
      search: false,
      selectedUsers: [],
    };
  },
  created: function() {
    axios.get(`${API_PATH}/picks`).then((response) => {
      this.pools = response.data
      this.loading = false;
      if (!this.gameDay) {
        axios.get(`${API_PATH}/scores`).then((scoreResponse) => {
          this.scores = scoreResponse.data.scores;
        });
      }
    });
  },
  /* eslint-disable no-console */
  methods: {
    choose(choice) {
      this.search = false;
      this.choice = choice;
    },
    home() {
      this.choice = null;
      this.search = false;
    },
    searchPage() {
      this.search = true;
      this.choice = null;
    }
  },
  computed: {
    entries() {
      return Object.keys(this.pools.entries).sort();
    },
    num() {
      if (this.choice) {
        return Number(this.choice);
      }
      return 1;
    }
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

.md-table-cell-container {
  padding-left: 12px !important;
  padding-right: 12px !important;
}

.md-button.md-primary {
  min-width: 30px !important;
}

.searchTable {
  text-align: left !important;
}
</style>
