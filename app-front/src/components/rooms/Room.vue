<!-- <template>
  <div class="">
    <h1>{{room.title}} </h1>
    <div id="chatbox">
      <div id="list_messages">
        <article class="chat-line" v-for="message in messages" :message="message">
          <span class="speaker">{{ message.sender_user }} </span>
          <span class="body">{{ message.content }}</span>
        </article>
      </div>
    </div>
    <div id="form_mssg" class="type_msg">
      <div class="input_msg_write">
        <input id="message_content" v-model="box_message" @keyup.enter="send_message" placeholder="Say something..." class="write_msg">
        <button @click="send_message" ref="sendMessage" class="msg_send_btn">
        >
        </button>
      </div>
    </div>
  </div>
</template> -->
<template>
  <div class="box-chat card border-0 rounded">
      <div class="card-header">
        <h3>{{room.title}}</h3>
      </div>
      <div class="card box-msg">
          <div class="balon1">
              <span class="msg-content">Hey there! What's up? </span>
              <span class="msg-sender">You - 3:22 pm</span>
          </div>
          <div
            :class="[ current_user==message.sender_user  ? 'balon1' : 'balon2' ]"
            v-for="message in messages" :message="message">
              <span class="msg-content">{{ message.content }}</span>
              <span class="msg-sender">{{ message.sender_user }} - {{ message.date }} </span>
          </div>
      </div>
      <div class="card-footer">
          <b-form @submit="send_message" >
              <b-row>
                  <div class="col-9 m-0 p-1">

                    <b-form-input
                      id="message_content"
                      type="text"
                      v-model="box_message"
                      required
                      placeholder="Type a message..." />

                  </div>
                  <div class="col-3 m-0 p-1">
                      <button
                        type="submit"
                        class="btn btn-outline-secondary rounded border w-100"
                        title="Send!"
                        style="padding-right: 16px;">
                          Send<i class="fa fa-paper-plane" aria-hidden="true"></i>
                      </button>
                  </div>
              </b-row>
          </b-form>
      </div>
  </div>
</template>
<script>
import auth from '../../backend/auth'
export default {
  data () {
    return {
      room_id: this.$route.params.id,
      room: {},
      box_message: '',
      messages: [],
      current_user: localStorage.username
    }
  },
  channels: {
        'RoomChannel': {
            connected() {
                console.log('I am connected.');
            },
            received(data) {
              this.messages.push(data.message)
            }
        }
  },
  created() {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.get('http://localhost:3000/api/v1/rooms/' + this.room_id)
        .then(response => {
          if (response.status === 200) {
            this.messages = response.body.messages
            this.room = response.body.room
          }
        })
        .catch(error => {
          console.error(error)
        })
      }
  },
  methods: {
    send_message: function(event){
        if(this.box_message != ""){
          this.$cable.perform({
            channel: 'RoomChannel',
            action: 'speak',
            data: {
              message: this.box_message,
              room_id: this.room_id,
            }
          });
          this.box_message = ""
        }
        event.preventDefault();
    }
  },
  mounted() {
      this.$cable.subscribe({ channel: 'RoomChannel', room_id: this.room_id});
  }
}
</script>

<style>
  @import '../../assets/styles/room_chat.css';
</style>
