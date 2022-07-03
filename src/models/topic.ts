import {
  Column,
  CreateDateColumn,
  Entity,
  ManyToOne,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import { Todo } from './todo';

@Entity()
export class Topic {
  @PrimaryGeneratedColumn()
  readonly id = 0;

  @ManyToOne(() => Todo, (todo: Todo) => todo.topic, { cascade: true })
  todos: Todo[] = [];

  @Column({ unique: true })
  name = '';

  @Column({ default: '' })
  description = '';

  @CreateDateColumn()
  readonly createdAt: Date = new Date();

  @UpdateDateColumn()
  readonly updatedAt: Date = new Date();
}
