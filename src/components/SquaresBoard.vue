<template>
  <md-table md-card>
    <md-table-toolbar>
      <h1 class="md-title" style="flex: 1">{{pool}} Pool</h1>
    </md-table-toolbar>

    <md-table-row class="noHover">
      <md-table-cell v-for="(number, index) in afc.q1" v-bind:key="number + index"
                     v-bind:class="{ divider: number, noHover: true, thickRight: (index == 4)}">
                     {{number}}
      </md-table-cell>
    </md-table-row>

    <md-table-row class="noHover">
      <md-table-cell v-for="(number, index) in afc.q2" v-bind:key="number + index"
                     v-bind:class="{ divider: number, thickRight: (index == 4)}">
                     {{number}}
      </md-table-cell>
    </md-table-row>

    <md-table-row class="noHover">
      <md-table-cell v-for="(number, index) in afc.q3" v-bind:key="number + index"
                     v-bind:class="{ divider: number, thickRight: (index == 4)}">
                     {{number}}
      </md-table-cell>
    </md-table-row>

    <md-table-row class="noHover">
      <md-table-cell v-for="(number, index) in afc.m2" v-bind:key="number + index"
                     v-bind:class="{ divider: number, thickRight: (index == 4)}">
                     {{number}}
      </md-table-cell>
    </md-table-row>

    <md-table-row class="noHover thickBottom">
      <md-table-cell v-for="(number, index) in afc.q4" v-bind:key="number + index"
            v-bind:class="{ divider: number, thickBottom: true, thickRight: (index == 4) }">
                     {{number}}
      </md-table-cell>
    </md-table-row>

    <md-table-row v-for="(pick, y) in picks" v-bind:key="'row' + y">
      <md-table-cell class="divider">{{nfc.q1[y]}}</md-table-cell>
      <md-table-cell class="divider">{{nfc.q2[y]}}</md-table-cell>
      <md-table-cell class="divider">{{nfc.q3[y]}}</md-table-cell>
      <md-table-cell class="divider">{{nfc.m2[y]}}</md-table-cell>
      <md-table-cell class="divider thickRight">{{nfc.q4[y]}}</md-table-cell>
      <md-table-cell class="divider hover" v-for="(item, x) in pick" v-bind:key="item + y + x"
                     @click.native="toggle(item, x, y)">{{item}}</md-table-cell>
    </md-table-row>
    <md-dialog :md-active.sync="showModal">
      <md-table>
        <md-table-row class="">
          <md-table-head>{{pick}}</md-table-head>
          <md-table-head class="">AFC - NFC</md-table-head>
        </md-table-row>
        <md-table-row>
          <md-table-head>1st Quarter</md-table-head>
          <md-table-cell>{{afc['q1'][x+5]}} - {{nfc['q1'][y]}}</md-table-cell>
        </md-table-row>

        <md-table-row>
          <md-table-head>2nd Quarter</md-table-head>
          <md-table-cell>{{afc['q2'][x+5]}} - {{nfc['q2'][y]}}</md-table-cell>
        </md-table-row>

        <md-table-row>
          <md-table-head>3rd Quarter</md-table-head>
          <md-table-cell>{{afc['q3'][x+5]}} - {{nfc['q3'][y]}}</md-table-cell>
        </md-table-row>

        <md-table-row>
          <md-table-head>2 Minute Warning</md-table-head>
          <md-table-cell>{{afc['m2'][x+5]}} - {{nfc['m2'][y]}}</md-table-cell>
        </md-table-row>

        <md-table-row>
          <md-table-head>4th Quarter</md-table-head>
          <md-table-cell>{{afc['q4'][x+5]}} - {{nfc['q4'][y]}}</md-table-cell>
        </md-table-row>
      </md-table>

      <md-dialog-actions>
        <md-button class="md-primary" @click="showModal = false">Close</md-button>
      </md-dialog-actions>
    </md-dialog>
    <md-dialog v-if="showWinnersModal" :md-active.sync="showWinnersModal">
      <md-table>
        <md-table-row class="">
          <md-table-head>Quarter</md-table-head>
          <md-table-head>Winner</md-table-head>
          <md-table-head>Reverse</md-table-head>
          <md-table-head>Touching</md-table-head>
        </md-table-row>
        <md-table-row>
          <md-table-head>1st</md-table-head>
          <md-table-cell>
            {{(picks[winners.q1.winner.y] || [])[winners.q1.winner.x]}} ({{this.pool * 8}})
          </md-table-cell>
          <md-table-cell>
            {{(picks[winners.q1.reverse.y] || [])[winners.q1.reverse.x]}} ({{this.pool * 2}})
          </md-table-cell>
          <md-table-cell>
            {{getTouchingSquares(winners.q1.winner.x, winners.q1.winner.y)}} ({{this.pool}})
          </md-table-cell>
        </md-table-row>

        <md-table-row>
          <md-table-head>2nd</md-table-head>
          <md-table-cell>
            {{(picks[winners.q2.winner.y] || [])[winners.q2.winner.x]}} ({{this.pool * 12}})
          </md-table-cell>
          <md-table-cell>
            {{(picks[winners.q2.reverse.y] || [])[winners.q2.reverse.x]}} ({{this.pool * 4}})
          </md-table-cell>
          <md-table-cell>
            {{getTouchingSquares(winners.q2.winner.x, winners.q2.winner.y)}} ({{this.pool}})
          </md-table-cell>
        </md-table-row>

        <md-table-row>
          <md-table-head>3rd</md-table-head>
          <md-table-cell>
            {{(picks[winners.q3.winner.y] || [])[winners.q3.winner.x]}} ({{this.pool * 14}})
          </md-table-cell>
          <md-table-cell>
            {{(picks[winners.q3.reverse.y] || [])[winners.q3.reverse.x]}} ({{this.pool * 2}})
          </md-table-cell>
          <md-table-cell>
            {{getTouchingSquares(winners.q3.winner.x, winners.q3.winner.y)}} ({{this.pool}})
          </md-table-cell>
        </md-table-row>

        <md-table-row>
          <md-table-head>2m</md-table-head>
          <md-table-cell>
            {{(picks[winners.m2.winner.y] || [])[winners.m2.winner.x]}} ({{this.pool * 4}})
          </md-table-cell>
          <md-table-cell>
            <!-- {{(picks[winners.m2.reverse.y] || [])[winners.m2.reverse.x]}} -->
          </md-table-cell>
          <md-table-cell>
            <!-- {{getTouchingSquares(winners.m2.winner.x, winners.m2.winner.y)}} -->
          </md-table-cell>
        </md-table-row>

        <md-table-row>
          <md-table-head>4th</md-table-head>
          <md-table-cell>
            {{(picks[winners.q4.winner.y] || [])[winners.q4.winner.x]}} ({{this.pool * 30}})
          </md-table-cell>
          <md-table-cell>
            {{(picks[winners.q4.reverse.y] || [])[winners.q4.reverse.x]}} ({{this.pool * 8}})
          </md-table-cell>
          <md-table-cell>
            {{getTouchingSquares(winners.q4.winner.x, winners.q4.winner.y)}} ({{this.pool}})
          </md-table-cell>
        </md-table-row>
      </md-table>

      <md-dialog-actions>
        <md-button class="md-primary" @click="showWinnersModal = false">Close</md-button>
      </md-dialog-actions>
    </md-dialog>
  </md-table>
</template>

<script>
import axios from 'axios';

const API_PATH = 'https://api.db94.io/squares';

export default {
  name: 'App',
  props: ['pool', 'pools', 'gameDay', 'scores'],
  data() {
    return {
      showModal: false,
      showWinnersModal: false,
      pick: null,
      x: null,
      y: null,
      localScores: null,
      winners: {
        q1: {
          winner: {
            x: null,
            y: null,
          },
          reverse: {
            x: null,
            y: null,
          },
        },
        q2: {
          winner: {
            x: null,
            y: null,
          },
          reverse: {
            x: null,
            y: null,
          },
        },
        q3: {
          winner: {
            x: null,
            y: null,
          },
          reverse: {
            x: null,
            y: null,
          },
        },
        m2: {
          winner: {
            x: null,
            y: null,
          },
          reverse: {
            x: null,
            y: null,
          },
        },
        q4: {
          winner: {
            x: null,
            y: null,
          },
          reverse: {
            x: null,
            y: null,
          },
        },
      },
    };
  },
  computed: {
    localScore() {
      return this.localScores ? this.localScores : this.scores;
    },
    afc() {
      return this.pools.afc;
    },
    nfc() {
      return this.pools.nfc;
    },
    picks() {
      return this.pools.picks;
    }
  },
  methods: {
    toggle(item, x, y) {
      this.pick = item;
      this.x = x;
      this.y = y;
      this.showModal = true;
    },
    getWinners() {
      const winners = { ...this.winners };
      this.localScore.forEach((score) => {
        winners[score.period].winner.x = this.getWinner(score.afc, this.afc[score.period]) - 5;
        winners[score.period].winner.y = this.getWinner(score.nfc, this.nfc[score.period]);
        winners[score.period].reverse.x = this.getWinner(score.nfc, this.afc[score.period]) - 5;
        winners[score.period].reverse.y = this.getWinner(score.afc, this.nfc[score.period]);
      });
      this.winners = winners;
      this.showWinnersModal = true;
    },
    getWinner(score, scores) {
      return scores.findIndex(x => x === score);
    },
    getTouchingSquares(x, y) {
      const touching = [];
      if (x !== null && x !== undefined && y !== null && y !== undefined) {
        touching.push(this.getTouchingSquare(x + 1, y));
        touching.push(this.getTouchingSquare(x - 1, y));
        touching.push(this.getTouchingSquare(x, y + 1));
        touching.push(this.getTouchingSquare(x, y - 1));
      } else {
        return null;
      }
      return touching.join(', ');
    },
    getTouchingSquare(x, y) {
      let touchingX = x;
      let touchingY = y;
      if (x === 10) {
        touchingX = 0;
      } else if (x === -1) {
        touchingX = 9;
      }

      if (y === 10) {
        touchingY = 0;
      } else if (y === -1) {
        touchingY = 9;
      }

      return this.picks[touchingY][touchingX];
    },
    getScores() {
      axios.get(`${API_PATH}/scores`).then((scoreResponse) => {
        this.localScores = scoreResponse.data.scores;
      });
    },
  },
};
</script>

<style>
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

.hover:hover {
  background-color: #ff5252 !important;
}
</style>
