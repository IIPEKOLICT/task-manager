import { Body, Controller, Delete, Get, Param, Patch, Post } from 'jovy';
import { EndPoint, Selector } from '../constants/enums';
import { Todo, Topic } from '../models';
import { todoService, topicService } from '../services';
import { DeleteDto, TopicDto } from '../abstractions/dtos';

@Controller(EndPoint.TOPICS)
export class TopicController {
  @Get()
  async getAll(): Promise<Topic[]> {
    return topicService.getAll();
  }

  @Get(Selector.ID)
  async getOne(@Param('id') id: string): Promise<Topic> {
    return topicService.getOne(+id);
  }

  @Get(Selector.TOPIC_TODOS)
  async getTopicTodos(@Param('topicId') topicId: string): Promise<Todo[]> {
    const topic: Topic = await topicService.getOne(+topicId);
    return todoService.getByTopic(topic);
  }

  @Post()
  async create(@Body() dto: Partial<TopicDto>): Promise<Topic> {
    return topicService.create(dto);
  }

  @Patch(Selector.ID)
  async change(@Param('id') id: string, @Body() dto: Partial<TopicDto>): Promise<Topic> {
    return topicService.change(+id, dto);
  }

  @Delete(Selector.ID)
  async delete(@Param('id') id: string): Promise<DeleteDto> {
    return { id: await topicService.delete(+id) };
  }
}
