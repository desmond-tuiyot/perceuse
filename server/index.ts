import express from 'express'
import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()
const app = express()
const port = 4000

app.use(express.json())

app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.get('/moves', async (req, res): Promise<void> => {
  const moves = await prisma.danceMove.findMany()
  res.send(moves)
})

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})
