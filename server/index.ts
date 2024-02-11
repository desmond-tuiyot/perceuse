import 'reflect-metadata'
import http from 'http'
import cors from 'cors'
import express from 'express'
import { ApolloServer } from '@apollo/server'
import { ApolloServerPluginDrainHttpServer } from '@apollo/server/plugin/drainHttpServer'
import { expressMiddleware } from '@apollo/server/express4'
import { buildSchema } from 'type-graphql'
import { resolvers } from './generated/type-graphql'
import { PrismaClient } from '@prisma/client'
import morgan from 'morgan'

import { TransitionResolver } from './modules/transition/transition-resolver'
import { SERVER_PORT, SERVER_GQL_PATH } from './constants'

const init = async () => {
  const PORT = process.env.PORT || SERVER_PORT
  const app = express()
  const prisma = new PrismaClient()

  // TODO: define cors when we have a frontend - https://www.apollographql.com/docs/apollo-server/security/cors/#specifying-origins
  app.use(cors())

  // TODO: define cookie parser when we have a frontend

  // TODO: log incoming requests and responses
  app.use(morgan('combined'))
  
  app.use(express.json())

  const httpServer = http.createServer(app)

  // Apollo server
  const createSchema = async () => {
    return await buildSchema({
      resolvers: [...resolvers, TransitionResolver],
      emitSchemaFile: true,
      validate: false,
    })
  }

  const schema = await createSchema()
  
  const server = new ApolloServer({
    schema,
    plugins: [ApolloServerPluginDrainHttpServer({ httpServer })],
    introspection: true
  })

  await server.start()

  app.use(
    '/graphql',
    express.json(),
    expressMiddleware(server, {
      context: async ({ req }) => ({ prisma, token: req.headers.token })
    }),
  )

  app.get('/', (_, res) => {
    res.send(`Perceuse API - <a href="${String(SERVER_GQL_PATH)}">To Playground</a>`)
  })

  app.get('/health-check', (_, res) => {
    res.type('application/health+json')
    res.json({ status: 'pass' })
  })

  await new Promise<void>(resolve => httpServer.listen({ port: PORT }, resolve))

  console.log(`boss-graphql-api live at http://localhost:${PORT}/graphql`)
  console.log(`Try your health check at: http://localhost:${PORT}/health-check`)
}

init().catch(error => console.log(error))