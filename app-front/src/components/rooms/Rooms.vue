<template>
  <div class="">
    <h1>List Rooms</h1>
    <b-alert show variant="danger" v-if="error">{{ error }}</b-alert>


    <b-modal id="add_room" ref="hide-footer" title="Add a new room">
      <div class="form-group">
          <label for="exampleInputEmail1">Name Room</label>
          <input @keyup.enter="addRoom" type="text" class="form-control" placeholder="Type room name" v-model="newRoom.name" >
      </div>
      <div slot="modal-footer" class="w-100">
        <button @click="addRoom()" class="btn btn-primary float-right">Submit</button>
      </div>
    </b-modal>

    <b-list-group style="margin: 2%;">
      <b-button v-b-modal.add_room variant="success" style="margin-bottom: 1%;">Add a new room</b-button>
      <b-list-group-item
        v-for="room in rooms"
        :key="room._id.$oid"
        :room="room"
        :to="{ name: 'room', params: {id: room._id.$oid } }">
          {{ room.title }}
      </b-list-group-item>
    </b-list-group>

  </div>
</template>

<script>
import auth from '../../backend/auth'
export default {
  name: 'Rooms',
  data () {
    return {
      rooms: [],
      newRoom: [],
      error: '',
      editedRoom: ''
    }
  },
  created() {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.get('http://localhost:3000/api/v1/rooms')
        .then(response => {
          if (response.status === 200) {
            this.rooms = response.body
          }
        })
        .catch(error => {
          console.error(error)
        })
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    addRoom () {
      const value = this.newRoom
      if (!value) {
        return
      }
      this.$http.post(
        'http://localhost:3000/api/v1/rooms',
        { room: { title: this.newRoom.name } },
        { headers: auth.getAuthHeader() })
        .then(response => {
          this.rooms.push(response.body)
          this.$router.push({ name: 'room', params: { id: response.body._id.$oid } })
        })
        .catch(error => this.setError(error, 'Cannot create room'))
    }
  }
}
</script>
