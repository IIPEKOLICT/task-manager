import {
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import { generateRandomColor } from '../shared/utils';

@Entity()
export class Tag {
  @PrimaryGeneratedColumn()
  readonly id = 0;

  @Column({ unique: true })
  name = '';

  @Column({ default: '' })
  color = generateRandomColor();

  @CreateDateColumn()
  readonly createdAt: Date = new Date();

  @UpdateDateColumn()
  readonly updatedAt: Date = new Date();
}
