-- SQL por si no hay un valor en una variable en JPQL

-- SQL por si no hay un valor en una variable en JPQL


 @Query("SELECT DISTINCT new com.ibm.onboarding.models.CandidateModel(c.candidateId, c.employeeNumber, c.managerIntranetId,"
	  + " CASE WHEN SIZE(c.candidateSkills) > 0 THEN true ELSE false END, CASE WHEN c.reasonToRotate IS NULL THEN false ELSE true END,"
	  + " c.status.statusId, c.status.description, c.name, c.candidateType.description, CASE WHEN band IS NULL THEN '' ELSE band.description END,"
	  + " c.referalContractEmail, c.provider, CASE WHEN (SELECT COUNT(co) FROM CandidateOpenseat co WHERE co.candidateId = c AND co.status.statusId != 3) > 0"
	  + " THEN false ELSE true END, c.bench) FROM Candidate c LEFT OUTER JOIN c.band band LEFT OUTER JOIN c.identifiedOpenseats io LEFT OUTER JOIN c.candidateSkills cks"
	  + " WHERE c.status.statusId = 2"
	  + " AND (c.candidateType.description = CASE WHEN (LOWER(:candidateType) != 'nothing') THEN :candidateType ELSE c.candidateType.description END )"
	  + " AND (c.primaryJrss.description =  CASE WHEN (LOWER(:jobRole) != 'nothing') THEN :jobRole ELSE c.primaryJrss.description END )"
	  + " AND (c.bench = CASE WHEN :bench != null THEN :bench ELSE c.bench END )"
	  + " AND (band.description = CASE WHEN (LOWER(:band) != 'nothing') THEN :band ELSE band.description END)"
	  + " AND (cks.skillId.description IN ( :skills ) )"
	  + " ORDER BY c.employeeNumber ASC")
    List<CandidateModel> findMyCandidatesAdvanced(@Param("candidateType") String candidateType, @Param("jobRole") String jobRole, @Param("bench") Boolean bench, @Param("band") String band, @Param("skills") List<String> skills);
    


    
@Query("SELECT DISTINCT new com.ibm.onboarding.models.CandidateModel(c.candidateId, c.employeeNumber, c.managerIntranetId,"
	  + " CASE WHEN SIZE(c.candidateSkills) > 0 THEN true ELSE false END, CASE WHEN c.reasonToRotate IS NULL THEN false ELSE true END,"
	  + " c.status.statusId, c.status.description, c.name, c.candidateType.description, CASE WHEN band IS NULL THEN '' ELSE band.description END,"
	  + " c.referalContractEmail, c.provider, CASE WHEN (SELECT COUNT(co) FROM CandidateOpenseat co WHERE co.candidateId = c AND co.status.statusId != 3) > 0"
	  + " THEN false ELSE true END, c.bench) FROM Candidate c LEFT OUTER JOIN c.band band LEFT OUTER JOIN c.identifiedOpenseats io LEFT OUTER JOIN c.candidateSkills cks"
	  + " WHERE c.status.statusId = 2"
	  + " AND (c.candidateType.description = CASE WHEN (LOWER(:candidateType) != 'nothing') THEN :candidateType ELSE c.candidateType.description END )"
	  + " AND (c.primaryJrss.description =  CASE WHEN (LOWER(:jobRole) != 'nothing') THEN :jobRole ELSE c.primaryJrss.description END )"
	  + " AND (c.bench = CASE WHEN :bench != null THEN :bench ELSE c.bench END )"
	  + " AND (band.description BETWEEN :band1 AND :band2)"
	  + " AND (cks.skillId.description IN ( :skills ) )"
	  + " ORDER BY c.employeeNumber ASC")
    List<CandidateModel> findMyCandidatesAdvanced2(@Param("candidateType") String candidateType, @Param("jobRole") String jobRole, @Param("bench") Boolean bench, @Param("band1") String band1, @Param("band2") String band2, @Param("skills") List<String> skills);
