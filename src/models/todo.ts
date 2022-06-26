import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class Todo {
  @PrimaryGeneratedColumn()
  readonly id: number = 0;

  @Column({ unique: true })
  header: string = '';

  @Column({ default: '' })
  text: string = '';

  @Column({ default: false })
  isCompleted: boolean = false;

  @Column({ default: false })
  isImportant: boolean = false;
}
