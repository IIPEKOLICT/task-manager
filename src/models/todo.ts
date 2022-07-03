import {
  Column,
  CreateDateColumn,
  Entity,
  JoinTable,
  ManyToMany,
  ManyToOne,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import { Priority } from '../constants/enums';
import { Tag } from './tag';
import { Topic } from './topic';

@Entity()
export class Todo {
  @PrimaryGeneratedColumn()
  readonly id = 0;

  @ManyToOne(() => Topic, (topic: Topic) => topic.todos, { cascade: true })
  topic: Topic;

  @ManyToMany(() => Tag, { cascade: true })
  @JoinTable()
  tags: Tag[] = [];

  @Column({ unique: true })
  header = '';

  @Column({ default: '' })
  text = '';

  @Column({ default: Priority.MEDIUM })
  priority = '';

  @Column({ default: false })
  isCompleted = false;

  @CreateDateColumn()
  readonly createdAt: Date = new Date();

  @UpdateDateColumn()
  readonly updatedAt: Date = new Date();
}
