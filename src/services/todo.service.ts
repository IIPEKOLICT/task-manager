import { BaseService } from '../core/base.service';
import { Todo } from '../models/todo';
import { ITodoService } from '../abstractions/interfaces';

export class TodoService extends BaseService<Todo> implements ITodoService {
  async create(dto: Partial<Todo>): Promise<Todo> {
    return this.repository.save(this.repository.create(dto));
  }

  async change(id: number, dto: Partial<Todo>): Promise<Todo> {
    const todo: Todo = await this.getOne(id);

    todo.header = dto.header || todo.header;
    todo.text = dto.text || todo.text;
    todo.isImportant = dto.isImportant || todo.isImportant;
    todo.isCompleted = dto.isCompleted || todo.isCompleted;

    await this.repository.save(todo);
    return todo;
  }
}
