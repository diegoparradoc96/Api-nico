import "dotenv/config";
import { defineConfig } from "prisma/config";

// Provide a local declaration for `process` so TypeScript won't error
// if @types/node is not installed. This narrows `process.env` to the
// subset we need for this config file.
declare const process: {
  env: {
    DATABASE_URL?: string;
    [key: string]: string | undefined;
  };
};

export default defineConfig({
  schema: "prisma/schema.prisma",
  migrations: {
    path: "prisma/migrations",
  },
  datasource: {
    url: process.env["DATABASE_URL"],
  },
});