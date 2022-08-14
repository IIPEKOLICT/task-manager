import { Body, Controller, Delete, Get, Param, Patch, Post } from 'jovy';
import { EndPoint, Selector } from '../constants/enums';
import { tagService, todoService, topicService } from '../services';
import { Tag, Todo, Topic } from '../models';
import { DeleteDto, TodoDto } from '../abstractions/dtos';

@Controller(EndPoint.TODOS)
export class TodoController {
  @Get()
  async getAll(): Promise<Todo[]> {
    return todoService.getAll();
  }

  @Get(Selector.ID)
  async getOne(@Param('id') id: string): Promise<Todo> {
    return todoService.getOne(+id);
  }

  @Post()
  async create(@Body() dto: Partial<TodoDto>): Promise<Todo> {
    const topic: Topic = await topicService.getOne(dto.topic);
    const tags: Tag[] = await tagService.getByIds(dto.tags);

    return todoService.create(topic, tags, dto);
  }

  @Patch(Selector.ID)
  async change(@Param('id') id: string, @Body() dto: Partial<TodoDto>): Promise<Todo> {
    const topic: Topic = await topicService.getOne(dto.topic);
    const tags: Tag[] = await tagService.getByIds(dto.tags);

    return todoService.change(+id, topic, tags, dto);
  }

  @Delete(Selector.ID)
  async delete(@Param('id') id: string): Promise<DeleteDto> {
    const todo: Todo = await todoService.removeTagsFromTodo(+id);
    return { id: await todoService.delete(todo.id) };
  }
}
