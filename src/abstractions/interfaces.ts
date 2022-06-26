import { Todo } from '../models/todo';

export interface IBaseService<M> {
  getAll(): Promise<M[]>;
  getOne(id: number): Promise<M>;
  delete(id: number): Promise<number>;
}

export interface ITodoService extends IBaseService<Todo> {
  create(dto: Partial<Todo>): Promise<Todo>;
  change(id: number, dto: Partial<Todo>): Promise<Todo>;
}
