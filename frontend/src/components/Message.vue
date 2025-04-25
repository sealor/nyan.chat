<script setup lang="ts">
  import { computed } from 'vue'

  import DOMPurify from 'isomorphic-dompurify'
  import {marked} from 'marked'

  marked.use({
    breaks: true,
    gfm: true,
  })

  interface Message {
    name: string,
    timestamp: Date,
    text: string,
  }

  const props = defineProps<{ message: Message }>()

  const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const avatarColor = computed(() => {
    const firstChar = props.message.name.at(0) || "A"
    let index = alphabet.indexOf(firstChar.toUpperCase())

    if (index === -1) return "#666"

    const hue = Math.round((index / 25) * 360)
    return `hsl(${hue}, 70%, 45%)`
  })

  const text = computed(() => {
    return DOMPurify.sanitize(marked.parse(props.message.text))
  })
</script>

<template>
  <div class="message left">
    <div class="avatar" :style="{ 'background-color': avatarColor }">{{ message.name[0] }}</div>
    <div class="message-body">
      <div class="message-header">
        <span class="name">{{ message.name }}</span>
        <span class="timestamp">{{ message.timestamp }}</span>
      </div>
      <div class="message-text" v-html="text"></div>
    </div>
  </div>
</template>


<style>
  .message.left {
    display: flex;
    align-items: flex-start;
    margin-bottom: 16px;
    max-width: 85%;
  }

  .avatar {
    width: 48px;
    height: 48px;
    margin-right: 3px;
    background-color: #6c757d;
    color: #fff;
    font-weight: 600;
    font-size: 1.4em;
    border-radius: 5px;
    display: flex;
    align-items: center;
    justify-content: center;
    text-transform: uppercase;
    font-family: sans-serif;
  }

  .message-body {
    padding: 5px 12px;
    max-width: 100%;
  }

  .message-header {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 4px;
    font-size: 1em;
    color: #555;
  }

  .message-header .name {
    font-weight: 600;
    color: #2f343d;
  }

  .message-header .timestamp {
    font-size: 0.75em;
    color: #888;
  }

  .message-text {
    font-size: 1em;
    color: #2f343d;
    line-height: 1.4;
  }

  .message-text * {
    margin: 0px;
  }

  .message-text blockquote {
    margin: 5px 0px;
    padding: 5px 0px 5px 12px;
    border-left: 3px solid #aaa;
    background-color: #f1f1f1;
  }

  .message-text pre {
    margin: 5px 0px;
    padding: 7px;
    border: 1px solid #bbb;
    border-radius: 5px;
    font-size: 1.1em;
  }
</style>
