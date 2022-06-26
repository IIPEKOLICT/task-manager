import { Body, Controller, Delete, Get, Param, Patch, Post } from 'jovy';
import { EndPoint, Selector } from '../constants/enums';
import { todoService } from '../services';
import { Todo } from '../models/todo';
import { DeleteDto } from '../abstractions/dtos';

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
  async create(@Body() dto: Partial<Todo>): Promise<Todo> {
    return todoService.create(dto);
  }

  @Patch(Selector.ID)
  async change(@Param('id') id: string, @Body() dto: Partial<Todo>): Promise<Todo> {
    return todoService.change(+id, dto);
  }

  @Delete(Selector.ID)
  async delete(@Param('id') id: string): Promise<DeleteDto> {
    return { id: await todoService.delete(+id) };
  }
}
