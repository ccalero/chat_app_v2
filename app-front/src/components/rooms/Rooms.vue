<template>
  <div class="">
    <h1>Rooms</h1>
    <div class="alert alert-danger" role="alert" v-if="error">
      {{ error }}
    </div>

    <h3 class="">Add a new room</h3>
    <form action="" @submit.prevent="addRoom">
      <div class="form-group">
        <label for="exampleInputEmail1">Name Room</label>
        <input class="form-control" v-model="newRoom.name" />
      </div>
      <button type="submit" class="btn btn-primary">Submit</button>
    </form>

    <hr class="border border-grey-light my-6" />
    <div class="row">
      <div class="col-4">
        <div class="list-group" id="list-tab" role="tablist">
          <ul>
            <li class="list-group-item list-group-item-action" v-for="room in rooms" :key="room._id.$oid" :room="room">
              <router-link :to="{ name: 'room', params: {id: room._id.$oid } }">{{ room.title }}</router-link>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
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
  mounted() {
      this.$http.get('http://localhost:3000/api/v1/rooms')
        .then(response => {
          if (response.status === 200) {
            this.rooms = response.body
          }
        })
        .catch(error => {
          console.error(error)
        })
    },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('/api/v1/rooms')
        .then(response => { this.rooms = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))
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
      this.$http.secured.post('/api/v1/rooms/', { room: { name: this.newRoom.name } })

        .then(response => {
          this.rooms.push(response.data)
          this.newRoom = ''
        })
        .catch(error => this.setError(error, 'Cannot create room'))
    },
    removeRoom (room) {
      this.$http.secured.delete(`/api/v1/rooms/${room.id}`)
        .then(response => {
          this.rooms.splice(this.rooms.indexOf(room), 1)
        })
        .catch(error => this.setError(error, 'Cannot delete room'))
    },
    editRoom (room) {
      this.editedRoom = room
    },
    updateRoom (room) {
      this.editedRoom = ''
      this.$http.secured.patch(`/api/v1/rooms/${room.id}`, { room: { title: room.name } })
        .catch(error => this.setError(error, 'Cannot update room'))
    }
  }
}
</script>
