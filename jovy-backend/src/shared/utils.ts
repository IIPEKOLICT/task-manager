import { IterableDto } from '../abstractions/dtos';

const HEX_ALPHABET: string[] = '0123456789ABCDEF'.split('');

export const generateRandomColor = (): string => {
  return Array.from(new Array(6).keys()).reduce((acc: string) => {
    return acc + HEX_ALPHABET[Math.round(Math.random() * (HEX_ALPHABET.length - 1))];
  }, '');
};

export const updateEntityFields = <T>(entity: T, dto: IterableDto, fields = ''): T => {
  const fieldsArr: string[] = fields.split(' ');

  if (!fieldsArr.length) return entity;

  return fieldsArr.reduce((acc: T, field: string) => {
    if (dto[field]) {
      (acc as IterableDto)[field] = dto[field];
    }

    return acc;
  }, entity);
};
