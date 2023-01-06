#!/bin/sh
cd XUnit.Coverlet.Collector
mkdir -p .results
rm -r -f .results/*
dotnet test --collect:"XPlat Code Coverage" -r .results/log -l trx
result=$?
dotnet tool install --global dotnet-reportgenerator-globaltool --version 5.1.13 --ignore-failed-sources
reportgenerator -reports:`find .results -name coverage.cobertura.xml` -targetdir:.results/reports
if [ $result = 0 ]; then
    echo "All tests passed!"
else
    echo "Some tests failed :("
fi
exit $result