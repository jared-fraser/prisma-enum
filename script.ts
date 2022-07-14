import { PrismaClient, TestingEnumKind, SourceEnum } from "@prisma/client";

const prisma = new PrismaClient();

type TestingEnumRes = {
  id: String;
  title: String;
  kind: TestingEnumKind;
};

// A `main` function so that you can use async/await
async function main() {
  // ... you will write your Prisma Client queries here
  const allTestingEnums = await prisma.$queryRaw<TestingEnumRes[]>`
      SELECT pt.id, te.title, te.kind 
      FROM parent_tests pt
      INNER JOIN testing_enums te ON (pt.enum_id = te.id)
      AS OF SYSTEM TIME '-1s'
      WHERE te.kind = ${TestingEnumKind.affirmation}
      AND te.source = ${SourceEnum.testA}`;
  // use `console.dir` to print nested objects

  console.dir(allTestingEnums, { depth: null });
}

main()
  .catch((e) => {
    throw e;
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
