import { Transition } from '../../generated/type-graphql'
import { Resolver, Mutation, Ctx, Arg } from 'type-graphql'

@Resolver(of => Transition)
export class TransitionResolver {
  @Mutation(returns => Transition, { nullable: false })
  async createTransition(
    @Ctx() { prisma }: any,
    @Arg('danceMove1Id') danceMove1Id: number,
    @Arg('danceMove2Id') danceMove2Id: number,
    @Arg('name', { nullable: true }) name?: string,
    @Arg('description', { nullable: true }) description?: string
  ): Promise<Transition> {
    try {
      const existingTransition = await prisma.transition.findFirst({
        where: {
          OR: [
            {
              AND: {
                danceMove1Id: { equals: danceMove1Id },
                danceMove2Id: { equals: danceMove2Id }
              }
            },
            {
              AND: {
                danceMove1Id: { equals: danceMove2Id },
                danceMove2Id: { equals: danceMove1Id }
              }
            }
          ]
        }
      })
  
      if (existingTransition != null) {
        throw new Error('Transition already exists')
      }

      let transitionName = name
      if (name == null) {
        const danceMove1 = await prisma.danceMove.findUnique({ where: { id: danceMove1Id } })
        const danceMove2 = await prisma.danceMove.findUnique({ where: { id: danceMove2Id } })
        transitionName = `${danceMove1?.name} - ${danceMove2?.name}`
      }

      return prisma.transition.create({
        data: {
          name: transitionName,
          description: description ?? '',
          danceMove1: {
            connect: { id: danceMove1Id }
          },
          danceMove2: {
            connect: { id: danceMove2Id }
          }
        }
      })
    } catch (error) {
      console.log(error)
      throw new Error('Failed to create transition')
    }
  }
}